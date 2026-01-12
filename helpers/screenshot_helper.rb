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

  # Capture:
  #  - a single "current viewport" screenshot (at whatever scroll position the page failed on)
  #  - a series of tiled screenshots from the TOP of the page downwards, stepping in viewport-height chunks until we cover the full document height.
  def capture_view_and_page_tiles(scenario)
    Dir.mkdir("screenshots") unless Dir.exist?("screenshots")

    timestamp = Time.now.strftime("%Y%m%d-%H%M%S")
    filename  = scenario.name.gsub(/\s+/, "_").gsub(/[^0-9A-Za-z_]/, "")
    base_path = File.join("screenshots", "#{filename}_#{timestamp}")

    view_path = "#{base_path}_VIEW.png"

    # 1) Capture the "current viewport view" (whatever scroll position we are at on failure)
    Capybara.page.save_screenshot(view_path)
    puts "## Failure - Current viewport screenshot saved: #{view_path}"
    tile_paths = []

    begin
      # 2) Get document height, viewport height, and current scroll position
      doc_height, viewport_height, original_scroll_y = page.evaluate_script(<<~JS)
        (function() {
          var body = document.body;
          var html = document.documentElement;

          var docHeight = Math.max(
            body.scrollHeight,
            html.scrollHeight,
            body.offsetHeight,
            html.offsetHeight,
            body.clientHeight,
            html.clientHeight
          );

          var viewportHeight = window.innerHeight || html.clientHeight;
          var scrollY = window.scrollY || html.scrollTop || body.scrollTop || 0;
          return [docHeight, viewportHeight, scrollY];
        })();
      JS

      doc_height         = doc_height.to_i
      viewport_height    = viewport_height.to_i
      original_scroll_y  = original_scroll_y.to_i

      # puts "Page metrics: doc_height=#{doc_height}, viewport_height=#{viewport_height}, original_scroll_y=#{original_scroll_y}" # for local debug

      # If the page fits in one viewport, we will still take a single tile from the top this way, we always have a "canonical" first tile.
      num_tiles = (doc_height.to_f / viewport_height).ceil
      num_tiles = 1 if num_tiles < 1

      puts "# Tiling page into #{num_tiles} viewport-height screenshot(s) to give us a full page view even on older browsers. ##"

      # 3) Scroll from top in viewport-sized steps and capture each tile
      (0...num_tiles).each do |index|
        scroll_y = viewport_height * index
        scroll_y = doc_height - viewport_height if scroll_y + viewport_height > doc_height
        scroll_y = 0 if scroll_y.negative?

        page.execute_script("window.scrollTo(0, #{scroll_y});")
        sleep 0.2 # allow layout/scroll to settle a bit

        tile_path = "#{base_path}_TILE#{index + 1}.png"
        Capybara.page.save_screenshot(tile_path)
        tile_paths << tile_path

        puts "# Tile #{index + 1}/#{num_tiles} screenshot saved: #{tile_path}"
      end
    rescue StandardError => e
      warn "# Tiled screenshots failed: #{e.class}: #{e.inspect}"
    ensure
      # 4) Restore original scroll position (so test state isn't surprised)
      begin
        page.execute_script("window.scrollTo(0, #{original_scroll_y || 0});")
      rescue StandardError => e
        warn "# Failed to restore original scroll position: #{e.class}: #{e.inspect}"
      end
    end

    {
      view: view_path,
      tiles: tile_paths,
    }
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
