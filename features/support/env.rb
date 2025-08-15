require 'capybara/cucumber'
require 'selenium-webdriver'
require 'yaml'
require 'allure-cucumber'

########################################
# Allure Reporting Configuration
########################################
AllureCucumber.configure do |config|
  config.results_directory = 'reports/allure-results'
  config.clean_results_directory = true
end

########################################
# Helper Modules & Config Files
########################################
require_relative '../../helpers/env_helpers'
require_relative '../../helpers/url_nav_helpers'

SECRETS  = EnvHelpers.load_secrets.freeze
SETTINGS = EnvHelpers.load_settings.freeze

World(EnvHelpers)

########################################
# Browser & Window Settings (loaded based on run config)
########################################
browser        = SETTINGS["browser"]        || "chrome"
window_width   = SETTINGS["window_width"]   || 1920
window_height  = SETTINGS["window_height"]  || 1080
max_wait_time  = SETTINGS["max_wait_time"]  || 5

########################################
# Capybara Driver Registration
########################################
Capybara.register_driver :custom_selenium do |app|
  options =
    case browser
    when "firefox"
      opts = Selenium::WebDriver::Firefox::Options.new
      opts.add_argument("--width=#{window_width}")
      opts.add_argument("--height=#{window_height}")
      opts
    when "safari"
      Selenium::WebDriver::Safari::Options.new
    when "edge"
      Selenium::WebDriver::Edge::Options.new
    when "headless_chrome"
      opts = Selenium::WebDriver::Chrome::Options.new
      opts.add_argument('--headless')
      opts.add_argument('--disable-gpu')
      opts.add_argument("--window-size=#{window_width},#{window_height}")
      opts
    else # chrome
      opts = Selenium::WebDriver::Chrome::Options.new
      opts.add_argument("--window-size=#{window_width},#{window_height}")
      opts
    end

  Capybara::Selenium::Driver.new(
    app,
    browser: (browser == "headless_chrome" ? :chrome : browser.to_sym),
    options: options
  )
end

########################################
# Capybara Defaults
########################################
Capybara.default_driver = :custom_selenium
Capybara.default_max_wait_time = max_wait_time
