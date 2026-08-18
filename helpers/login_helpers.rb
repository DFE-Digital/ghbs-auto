# frozen_string_literal: true

require "net/http"
require "components/dfe_signin/dfe_signin_access_the_service_page_comps"
require "helpers/logger_helpers"
require "helpers/validation_helpers"

# Helper methods to make login flows more resilient in unstable environments
# (e.g. Test DfE Sign-In intermittently returning stale elements or broken sessions).
#
# These methods provide:
# - Controlled retry logic around login attempts
# - Safe recovery back to a known start state between retries
# - Recovery from transport leveel failures between Ruby and the chromedriver
#
# NOTE:
# This is intentionally defensive and slightly "ugly but reliable".
# It exists to stabilise CI where external auth services are flaky.

module LoginHelpers
  include LoggerHelpers
  include ValidationHelpers

  # Net::ReadTimeout with #<TCPSocket:(closed)> is a Timeout::Error and NOT a Selenium::WebDriver::Error
  # So in simple terms Errors that mean "the ruby connection to th chromedriver broke" as apposed to "the page was in the wrong state etc"
  # With this in mind, the IOError covers the following on "closed stream" ie when Ruby closes the socket when it gives up on read but
  # the Net::HTTP still believes the connection is started, hence the next command refuses a dead socket instead of opening a new one!

  TRANSPORT_ERRORS = [
    Net::ReadTimeout,
    Net::OpenTimeout,
    Errno::ECONNRESET,
    Errno::EPIPE,
    Errno::ECONNABORTED,
    Errno::ECONNREFUSED,
    EOFError,
    IOError,
  ].freeze

  # Now we take a brief pause before poking the driver again after the transport failure.
  # So were keeping this one short. The chrome driver handles a sessions commands serially, so if the command that timed out is still
  # running, the liveness probe will wait behind it and returns when its finished.
  # So the probe is what actually waits for the ddrain here, and its bounded by the driver read timeout.
  # Note: this pause only covers the gap between Ruby abandoning the socket and chrome driver and stacks on top of the retry loops own sleep_s.

  TRANSPORT_SETTLE_SECONDS = 3

  # Wraps a login flow in retry logic to handle transient Selenium/Capybara failures.
  # Retries the provided block up to `max_attempts`, catching common flaky errors
  # such as stale elements, detached nodes, or unexpected navigation failures.
  # @param max_attempts [Integer] Maximum number of retry attempts
  # @param sleep_s [Integer] Seconds to wait between retries
  # @param reset_between [Boolean] Whether to reset the browser session between attempts
  # @raise [Exception] Re-raises the last encountered error if all retries fail
  def defensive_login_retry(max_attempts:, sleep_s:, reset_between: false)
    attempt = 0
    last_error = nil

    while attempt < max_attempts
      attempt += 1

      begin
        yield(attempt)
        return
      rescue Selenium::WebDriver::Error::UnknownError,
             Selenium::WebDriver::Error::StaleElementReferenceError,
             Selenium::WebDriver::Error::InvalidSessionIdError,
             Selenium::WebDriver::Error::TimeoutError,
             Selenium::WebDriver::Error::NoSuchWindowError,
             Capybara::ElementNotFound,
             Capybara::ExpectationNotMet,
             RSpec::Expectations::ExpectationNotMetError,
             *TRANSPORT_ERRORS => e

        last_error = e
        log_warn("Login retry (attempt #{attempt}/#{max_attempts}) after error: #{e.class}: #{e.message}")
        # If we've exhausted retries, bubble up the failure
        raise if attempt >= max_attempts

        # Optional hard reset of browser state between attempts
        Capybara.reset_sessions! if reset_between

        # Small delay to allow backend/auth service to recover
        sleep sleep_s
      end
    end

    raise last_error if last_error
  end

  # Restores the browser to a known login start state between retry attempts.
  #
  # Two distinct recovery paths are now here:
  # 1. Transport failures (ie the socket died) recover the connection/session and reload.
  # 2. Everything else, ie normal selenium fails.
  #
  # Both paths coverage on visiting 'return_url' and waiting for the page to be ready.
  # This progressive approach avoids unnecessary session resets while still recovering from deeper failures when needed.
  # @param attempt [Integer] Current retry attempt number
  # @param return_url [String] URL to return to (must be the login entry point)
  # @param last_error [Exception, nil] Error that eended the previous attempt
  # @param ready_selector [String, nil] Xpath proving the start statre loaded. Defaults to the DfE Sign-in username field
  def restore_start_state(attempt:, return_url:, last_error: nil, ready_selector: nil)
    attempt = attempt.to_i
    return if attempt <= 1

    raise ArgumentError, "return_url is required" if return_url.to_s.strip.empty?

    if transport_error?(last_error)
      recover_from_transport_error(attempt: attempt, error: last_error)
    else
      restore_start_state_by_escalation(attempt)
    end

    visit return_url

    expected_selector = ready_selector || dfe_signin_access_the_service_page_comps.input_username_xpath
    expect(page).to have_selector(:xpath, expected_selector, wait: 10)
  end

private

  def transport_error?(error)
    !error.nil? && TRANSPORT_ERRORS.any? { |klass| error.is_a?(klass) }
  end

  # Recovery from page-state failures, avoids sessions resets while still recovering from deeper failures when needed.

  def restore_start_state_by_escalation(attempt)
    case attempt
    when 2
      log_info("Restoring start state (attempt #{attempt}): visit return_url")

    when 3
      log_info("Restoring start state (attempt #{attempt}): refresh + visit return_url")
      safely { page.refresh }

    when 4
      log_info("Restoring start state (attempt #{attempt}): reset session + visit return_url")
      Capybara.reset_sessions!

    else
      log_info("Restoring start state (attempt #{attempt}): hard reset + visit return_url")
      safely { Capybara.reset_sessions! }
      safely { page.driver.browser.manage.delete_all_cookies }
    end
  end

  # Recovers from a transport-level failure with a direction to keep the existing browser
  # This is usually caused by the socket between Ruby and chromedriver breaking
  def recover_from_transport_error(attempt:, error:)
    log_warn("Transport failure (attempt #{attempt}): #{error.class}: #{error.message}")

    sleep TRANSPORT_SETTLE_SECONDS

    reset_driver_http_connection!

    if session_responsive?
      log_info("Browser session survived the transport failure - reloading in the same session")
      nil
    end
  end

  # Forces the new WebDriver command onto a fresh TCP connection.
  def reset_driver_http_connection!
    client = page.driver.browser.send(:bridge).http
    connection = client.instance_variable_get(:@http)

    connection.finish if connection.respond_to?(:started?) && connection.started?
    client.instance_variable_set(:@http, nil)

    log_info("Reset the WebDriver HTTP connection")
  rescue StandardError => e
    log_warn("Could not reset the WebDriver HTTP connection: #{e.class}: #{e.message}")
  end

  # Quick check to see if its alive, if the browser answers, the failure was a timeout against a healthy session rathjer than a dead driver!
  def session_responsive?
    page.driver.browser.title
    true
  rescue *TRANSPORT_ERRORS, Selenium::WebDriver::Error::StaleElementReferenceError => e
    log_warn("Browser session did not respond to a probe: #{e.class}: #{e.message}")
    false
  end

  def safely
    yield
  rescue StandardError => e
    log_warn("Ignored error during login recovery: #{e.class}: #{e.message}")
  end
end
