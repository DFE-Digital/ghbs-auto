require 'selenium-webdriver'

Before do
  browser = browser_type
  headless = setting("headless", default: false).to_s == "true"

  options = case browser
            when 'firefox'
              Selenium::WebDriver::Firefox::Options.new.tap { |o| o.headless! if headless }
            when 'safari'
              Selenium::WebDriver::Safari::Options.new
            when 'edge'
              Selenium::WebDriver::Edge::Options.new.tap { |o| o.add_argument('--headless') if headless }
            else
              Selenium::WebDriver::Chrome::Options.new.tap { |o| o.add_argument('--headless') if headless }
            end

  width, height = resolution
  self.driver = Selenium::WebDriver.for browser.to_sym, options: options
  driver.manage.window.resize_to(width, height)

  puts "🖥️  Starting browser: #{browser}, resolution: #{width}x#{height}"
end


After do |scenario|
  if scenario.failed? && setting("screenshots_on_failure", default: true)
    Dir.mkdir('screenshots') unless Dir.exist?('screenshots')
    timestamp = Time.now.strftime('%Y%m%d-%H%M%S')
    filename = "screenshots/#{scenario.name.gsub(/\s+/, '_')}_#{timestamp}.png"
    driver.save_screenshot(filename)
    puts "📸 Screenshot saved: #{filename}"
  end
  driver.quit
end
