# frozen_string_literal: true

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
        puts "[WARN] Login retry (attempt #{attempt}/#{max_attempts}) after error: #{e.class}: #{e.message}"
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
  # - Attempt 1: No action (assumes clean start)
  # - Attempt 2: Revisit the login entry point
  # - Attempt 3+: Reset session + revisit entry point
  # This progressive approach avoids unnecessary session resets while still recovering from deeper failures when needed.
  # @param attempt [Integer] Current retry attempt number
  # @param return_url [String] URL to return to (must be the login entry point)
  # @raise [ArgumentError] If return_url is missing or blank
  # Ensures the page is ready for login by waiting for the "Sign in" button.
  def restore_start_state(attempt:, return_url:)
    attempt = attempt.to_i
    # First attempt assumes clean state so no recovery needed
    return if attempt <= 1

    raise ArgumentError, "return_url is required" if return_url.to_s.strip.empty?

    if attempt == 2
      puts "[INFO] Restoring start state (attempt #{attempt}): visit return_url"
    else
      puts "[INFO] Restoring start state (attempt #{attempt}): reset session + visit return_url"
      Capybara.reset_sessions!
    end
    visit return_url

    # Basic assertion to confirm page is ready for interaction
    expect(page).to have_selector(:xpath, "//button[normalize-space()='Sign in']", wait: 20)
  end
end
