require_relative '../../helpers/screenshot_helper'
World(ScreenshotHelper)

Before do
  puts "###############################"
  puts "     Run Config / Settings     "
  puts "###############################"
  puts " Env profile:   #{RUN_ENV}"
  puts " Browser:       #{BROWSER}"
  puts " Resolution:    #{WINDOW_WIDTH},#{WINDOW_HEIGHT}"
  puts " Max wait time: #{MAX_WAIT}s"
  puts "###############################"
end

After do |scenario|
  next unless scenario.failed?
  begin
    path = capture_screenshot(scenario)
    attach_to_allure(path) if respond_to?(:attach_to_allure)
  rescue => e
    warn "Screenshot/Allure attach failed: #{e.class}: #{e.message}"
  end
end
