# frozen_string_literal: true

require "helpers/screenshot_helper"
require "pp"
World(ScreenshotHelper)

Before do
  # Start individual scenario timer
  @scenario_started_at = Time.now

  # Reset of flags before each scenario
  ENV["AXE"] = "false"

  # Reset shared per-scenario DTOs
  @case_state = CaseState.new
  @framework_state = FrameworkState.new
end

After do |scenario|
  status = scenario.failed? ? "FAILED" : "PASSED"

  # Manage debugging options for local dev
  if SECRETS["local_debug_case_state"] == true
    puts "[CASE_STATE]"
    pp case_state.to_h
  end

  total_run_time = Time.now - (@scenario_started_at || Time.now)
  puts "RUN TIME: #{status} in #{sprintf('%0.2f', total_run_time)}s"

  next unless scenario.failed?

  begin
    # 🔹 New: capture failure view + tiled full-page coverage
    screenshot_set = capture_view_and_page_tiles(scenario)
    view_path      = screenshot_set[:view]
    tile_paths     = screenshot_set[:tiles] || []

    if defined?(Allure)
      # Attach the failure view
      attach_to_allure(view_path, name: "Failure screenshot (failure view)")

      # Attach each tile as a separate attachment
      tile_paths.each_with_index do |tile_path, idx|
        attach_to_allure(
          tile_path,
          name: "Failure screenshot (page tile #{idx + 1})"
        )
      end

      # Existing text artefacts
      def allure_attach(name, content, mime)
        Allure.add_attachment(
          name: name,
          source: content, # pass a plain String or a File/IO
          type: mime,      # use MIME strings (works across versions)
          test_case: true
        )
      end

      allure_attach("Current URL", page.current_url.to_s, "text/plain")
      allure_attach("Page HTML", page.html.to_s, "text/html")
    end
  rescue StandardError => e
    warn "Screenshot/Allure attach failed: #{e.class}: #{e.inspect}"
  end
end
