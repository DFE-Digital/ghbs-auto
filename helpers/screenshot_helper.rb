# frozen_string_literal: true

module ScreenshotHelper
  def capture_screenshot(scenario)
    Dir.mkdir("screenshots") unless Dir.exist?("screenshots")

    timestamp = Time.now.strftime("%Y%m%d-%H%M%S")
    filename  = scenario.name.gsub(/\s+/, "_").gsub(/[^0-9A-Za-z_]/, "")
    path      = File.join("screenshots", "#{filename}_#{timestamp}.png")

    Capybara.page.save_screenshot(path)
    puts "📸 Screenshot saved: #{path}"
    path
  end

  def attach_to_allure(path, name: "Failure screenshot")
    Allure.add_attachment(
      name: name,
      source: File.open(path, "rb"),
      type: Allure::ContentType::PNG,
      test_case: true
    )
  end

  def attach_to_cucumber_html(path)
    attach(File.binread(path), "image/png", File.basename(path))
  end
end
