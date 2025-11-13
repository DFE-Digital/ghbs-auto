# frozen_string_literal: true

require "helpers/screenshot_helper"
World(ScreenshotHelper)

Before do
  # Start individual scenario timer
  @scenario_started_at = Time.now

  # Reset of flags before each scenario
  ENV["AXE"] = "false"

  # ensure clean state per scenario
  @case_state = CaseState.new
end

After do |scenario|
  status = scenario.failed? ? "FAILED" : "PASSED"
  puts "[CASE_STATE] #{case_state.to_h}"
  total_run_time = Time.now - (@scenario_started_at || Time.now)
  puts "RUN TIME: #{status} in #{sprintf('%0.2f', total_run_time)}s"

  next unless scenario.failed?

  begin
    path = capture_screenshot(scenario)
    attach_to_allure(path) if respond_to?(:attach_to_allure)

    if defined?(Allure)
      def allure_attach(name, content, mime)
        Allure.add_attachment(
          name: name,
          source: content, # pass a plain String or a File/IO
          type: mime, # use MIME strings (works across versions)
          test_case: true
        )
      end

      allure_attach("Current URL", page.current_url.to_s, "text/plain")
      allure_attach("Page HTML", page.html.to_s, "text/html")

    end
  rescue StandardError => e
    warn "Screenshot/Allure attach failed: #{e.class}: #{e.message}"
  end
end
