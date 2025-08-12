# helpers/screenshot_helper.rb
module ScreenshotHelper

  def capture_screenshot(scenario)
    timestamp = Time.now.strftime('%Y%m%d-%H%M%S')
    filename = scenario.name.gsub(/\s+/, '_').gsub(/[^0-9A-Za-z_]/, '')
    path = File.join('screenshots', "#{filename}_#{timestamp}.png")
    Capybara.page.save_screenshot(path)
    puts "📸 Screenshot saved: #{path}"
  end

end
