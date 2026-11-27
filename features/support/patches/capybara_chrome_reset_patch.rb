# frozen_string_literal: true

require "capybara"
require "capybara/selenium/driver"
require "selenium-webdriver"
require "capybara/selenium/driver_specializations/chrome_driver"

# TEMPORARY PATCH - Chrome 158 compatibility
#
# Introduced: 26/11/2026
# Affected Capybara version: 3.40.0 (last updated January 27, 2024!)
#
# Chrome 158 rejects the wildcard origin used by Capybara when clearing browser storage during session reset.
# Note: you will see this error "invalid argument: * is not a valid URL"
#
# Remove this patch once Capybara provides an official fix.
# Flow:
#           Scenario completes
#                   v
#         Normal Capybara reset!
#                   v
#     +------------------------------+
#     | Wildcard URL error occurs?   |
#     | "* is not a valid URL"       |
#     +------------------------------+
#          |                    |
#         No                   Yes
#          v                    v
#   Normal reset         Log warning and
#    completes            quit browser
#          |                    |
#          +---------+----------+
#                    v
#          Ready for next scenario

unless Capybara::VERSION == "3.40.0"
  raise "Capybara has been upgraded. Review and remove the Chrome 158 compatibility patch."
end

module CapybaraChromeResetPatch
  def reset!
    super
  rescue Selenium::WebDriver::Error::InvalidArgumentError => e
    raise unless e.message.include?("* is not a valid URL")

    warn "[WARN] Chrome compatibility patch: restarting browser session."
    quit
  end
end

Capybara::Selenium::Driver::ChromeDriver.prepend(
  CapybaraChromeResetPatch
)
