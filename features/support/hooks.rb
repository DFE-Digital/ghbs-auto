require_relative '../../helpers/screenshot_helper'
World(ScreenshotHelper)

Before do
  # Enriched logging
  resolved_browser = SETTINGS["browser"] || "chrome"
  window_width = SETTINGS["window_width"] || 1920
  window_height = SETTINGS["window_height"] || 1080
  max_wait_time = SETTINGS["max_wait_time"] || 1080
  puts "###############################"
  puts "     Run Config / Settings     "
  puts "###############################"
  puts " Env profile:   #{ENV['TEST_ENV'] || 'default'}"
  puts " Browser:       #{resolved_browser}"
  puts " Resolution:    #{window_width},#{window_height}"
  puts " max wait time: #{max_wait_time}s"
  puts "###############################"
end


After do |scenario|
  next unless scenario.failed?
  begin
    path = capture_screenshot(scenario)
    attach_to_allure(path)
  rescue => e
    warn "Screenshot/Allure attach failed: #{e.class}: #{e.message}"
  end
end
