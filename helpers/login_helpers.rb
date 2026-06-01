# frozen_string_literal: true

require "components/dfe_signin/dfe_signin_access_the_service_page_comps"
require "helpers/logger_helpers"
require "helpers/validation_helpers"

# Helper methods to make login flows more resilient in unstable environments
# (e.g. Test DfE Sign-In intermittently returning stale elements or broken sessions).
#
# These methods provide:
# - Controlled retry logic around login attempts
# - Safe recovery back to a known start state between retries
#
# NOTE:
# This is intentionally defensive and slightly "ugly but reliable".
# It exists to stabilise CI where external auth services are flaky.

module LoginHelpers
  include LoggerHelpers
  include ValidationHelpers
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
             Capybara::ElementNotFound,
             Capybara::ExpectationNotMet,
             RSpec::Expectations::ExpectationNotMetError => e

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
  # Behaviour differs slightly depending on attempt number:
  # This progressive approach avoids unnecessary session resets while still recovering from deeper failures when needed.
  # @param attempt [Integer] Current retry attempt number
  # @param return_url [String] URL to return to (must be the login entry point)
  # @raise [ArgumentError] If return_url is missing or blank
  # Ensures the page is ready for login by waiting for the "Sign in" button.
  def restore_start_state(attempt:, return_url:)
    attempt = attempt.to_i
    return if attempt <= 1

    raise ArgumentError, "return_url is required" if return_url.to_s.strip.empty?

    case attempt
    when 2
      log_info("Restoring start state (attempt #{attempt}): visit return_url")

    when 3
      log_info("Restoring start state (attempt #{attempt}): refresh + visit return_url")
      page.refresh

    when 4
      log_info("Restoring start state (attempt #{attempt}): reset session + visit return_url")
      Capybara.reset_sessions!

    else
      log_info("Restoring start state (attempt #{attempt}): hard reset + visit return_url")
      Capybara.reset_sessions!
      page.driver.browser.manage.delete_all_cookies
    end
    visit return_url
    expect(page).to have_selector(:xpath, dfe_signin_access_the_service_page_comps.input_username_xpath, wait: 10)
  end
end
