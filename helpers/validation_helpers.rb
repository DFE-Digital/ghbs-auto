# frozen_string_literal: true

module ValidationHelpers
  include Capybara::DSL

  def validate_values_match(expected, actual)
    expect(actual).to eq(expected), "Expected #{expected.inspect} but got #{actual.inspect}"
  end

  def validate_value_contains(expected, actual)
    expect(actual).to include(expected), "Expected #{actual.inspect} to include #{expected.inspect}"
  end

  def wait_for_element_to_include(element, expected, timeout: 10, downcase: false)
    matcher = downcase ? /#{Regexp.escape(expected.to_s)}/i : expected

    expect(element).to have_text(matcher, wait: timeout)
    true
  rescue Capybara::ExpectationNotMet
    raise "Timed out after #{timeout}s waiting for element to include #{expected.inspect}"
  end

  def element_present?(xpath, wait: Capybara.default_max_wait_time, **options)
    page.has_selector?(:xpath, xpath, wait: wait, **options)
  end

  def fetch_secret!(key)
    value = SECRETS[key]
    if value.nil? || value.to_s.strip.empty?
      raise "[ERROR] Missing secret '#{key}' in this runtime (nil/blank). Check GitHub Actions secrets/env mapping. But also check your shared-allure-core.yml!"
    end

    value
  end

  # Waits for a collection (provided via a block) to reach a minimum expected count,
  # refreshing the page periodically to pick up new elements (e.g. emails, results, files etc).
  #
  # Once the expected count is reached, waits briefly to allow any final elements to load,
  # performs one last refresh for consistency, and returns the cleaned text values.
  #
  # Params:
  # - expected_count_of_elements: Minimum number of elements we are waiting for
  # - refresh_page_every_x_seconds: How often to refresh the page while polling
  # - last_change_for_elements_to_drop_in: Final wait once count is reached to allow late arrivals
  # - timeout_s: Maximum time to wait before failing
  def wait_for_collection_count_then_capture(expected_count_of_elements:, refresh_page_every_x_seconds: 2, last_change_for_elements_to_drop_in: 1, timeout_s: 20)
    deadline = Time.now + timeout_s
    current_count = 0

    loop do
      collection = Array(yield)
      current_count = collection.count

      if current_count >= expected_count_of_elements
        sleep last_change_for_elements_to_drop_in
        page.driver.browser.navigate.refresh
        sleep 1
        return Array(yield).map { |el| el.text.strip }
      end

      raise "Timed out after #{timeout_s}s waiting for at least #{expected_count_of_elements} items. Last seen count: #{current_count}" if Time.now >= deadline

      page.driver.browser.navigate.refresh
      sleep refresh_page_every_x_seconds
    end
  end
end
