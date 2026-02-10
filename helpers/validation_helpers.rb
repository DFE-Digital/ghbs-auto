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

  def element_present?(xpath, **options)
    page.has_selector?(:xpath, xpath, **options.merge(wait: 0))
  end
end
