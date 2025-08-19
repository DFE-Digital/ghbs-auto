require 'capybara/cucumber'
require 'selenium-webdriver'
require 'yaml'
require 'allure-cucumber'

$LOAD_PATH.unshift(File.expand_path("../..", __dir__))

########################################
# Helper Modules & Config Files
########################################
require 'helpers/env_helpers'
require 'helpers/url_nav_helpers'

SECRETS  = EnvHelpers.load_secrets.freeze
SETTINGS = EnvHelpers.load_settings.freeze
World(EnvHelpers)

########################################
# Global Runtime settings (single source of truth), loaded based on run config
########################################
RUN_ENV      = ENV['TEST_ENV'] || 'default'
BROWSER      = SETTINGS['browser']        || 'chrome'
WINDOW_WIDTH = SETTINGS['window_width']   || 1920
WINDOW_HEIGHT= SETTINGS['window_height']  || 1080
MAX_WAIT     = SETTINGS['max_wait_time']  || 5


########################################
# Run Config / Settings (run before any cucumber is initiated )
########################################
def print_run_banner
  puts "###############################"
  puts "     Run Config / Settings     "
  puts "###############################"
  puts " Env profile:   #{RUN_ENV}"
  puts " Browser:       #{BROWSER}"
  puts " Resolution:    #{WINDOW_WIDTH},#{WINDOW_HEIGHT}"
  puts " Max wait time: #{MAX_WAIT}s"
  puts "###############################"
end

# print only once (single run or first parallel worker)
if ENV['TEST_ENV_NUMBER'].to_s.empty?
  #  ENV['TEST_ENV_NUMBER'] is set by parallel runners, most commonly the parallel_tests gem (parallel_cucumber).
  #   When you run bundle exec parallel_cucumber ... -n 4, it spawns 4 workers and sets:
  #   - worker 1: TEST_ENV_NUMBER="" (empty string)
  #   - worker 2: TEST_ENV_NUMBER="2"
  #   - worker 3: TEST_ENV_NUMBER="3", etc.
  #  If you’re not using a parallel runner, it’s unset (nil).
  #  Hence the above check is to ensure that we only this once!
  print_run_banner
end



########################################
# Allure Reporting Configuration
########################################
AllureCucumber.configure do |config|
  config.results_directory       = 'reports/allure-results'
  config.clean_results_directory = true

  # Put environment info here (shows on report main page)
  config.environment_properties = {
    test_environment: RUN_ENV,
    browser:          BROWSER,
    resolution:       "#{WINDOW_WIDTH}x#{WINDOW_HEIGHT}",
    max_wait_time:    "#{MAX_WAIT}s",
    os_platform:      RbConfig::CONFIG['host_os'],
    ruby_version:     RUBY_VERSION
  }
end

########################################
# Capybara Driver Registration
########################################
Capybara.register_driver :custom_selenium do |app|
  options =
    case BROWSER
    when 'firefox'
      opts = Selenium::WebDriver::Firefox::Options.new
      opts.add_argument("--width=#{WINDOW_WIDTH}")
      opts.add_argument("--height=#{WINDOW_HEIGHT}")
      opts
    when 'safari'
      Selenium::WebDriver::Safari::Options.new
    when 'edge'
      Selenium::WebDriver::Edge::Options.new
    when 'headless_chrome'
      opts = Selenium::WebDriver::Chrome::Options.new
      opts.add_argument('--headless')
      opts.add_argument('--disable-gpu')
      opts.add_argument("--window-size=#{WINDOW_WIDTH},#{WINDOW_HEIGHT}")
      opts
    else # chrome
      opts = Selenium::WebDriver::Chrome::Options.new
      opts.add_argument("--window-size=#{WINDOW_WIDTH},#{WINDOW_HEIGHT}")
      opts.add_option('goog:loggingPrefs', { browser: 'ALL' })
      opts
    end

  Capybara::Selenium::Driver.new(
    app,
    browser: (BROWSER == 'headless_chrome' ? :chrome : BROWSER.to_sym),
    options: options
  )
end

########################################
# Capybara Defaults
########################################

Capybara.default_driver        = :custom_selenium
Capybara.default_max_wait_time = MAX_WAIT
