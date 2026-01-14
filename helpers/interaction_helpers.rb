# frozen_string_literal: true

module InteractionHelpers
  def element_exists_across_pages?(
    target:,       # the element we are expecting to see
    next_button:,  # the element that contains the next button
    marker:,       # the marker element whose text should change per page
    max_pages: 200,
    wait: Capybara.default_max_wait_time,
    marker_change_timeout: nil # optional override, defaults to wait
  )
    pages_checked = 0
    marker_change_timeout ||= wait

    loop do
      pages_checked += 1
      raise "Exceeded max_pages (#{max_pages})" if pages_checked > max_pages

      # 1. Is element found on the current page?
      return true if target.call

      # 2. Is the Next button available?
      next_el = next_button.call
      disabled =
        next_el[:disabled] ||
        next_el[:'aria-disabled'] == "true" ||
        next_el[:class].to_s.include?("disabled")
      return false if disabled

      # 3. Capture current marker text (strip to avoid whitespace noise)
      # Example: Showing 1 to 10 of 23 results
      before = marker.call.text.strip

      # 4. Click next
      next_el.click

      # 5. Wait until the marker text has changed
      # e.g "Showing 1 to 10 of 23 results" to "Showing 11 to 20 of 23 results"
      # Important: use Capybara's waiting behaviour by checking has_text? / has_no_text?
      # rather than reading marker.call.text once.
      using_wait_time(marker_change_timeout) do
        # If marker is a stable element, re-read via marker.call each time
        changed = page.has_no_text?(before, wait: marker_change_timeout) ||
          marker.call.text.strip != before
        unless changed
          # Keep polling until it changes or wait expires
          expect(marker.call.text.strip).to_not eq(before)
        end
      end

      # if the UI updates in two steps, this ensures the marker has "settled" by
      # waiting until it becomes non-empty (or matches expected format)
      using_wait_time(marker_change_timeout) do
        expect(marker.call.text.strip).to_not be_empty
      end
    end
  end
end
