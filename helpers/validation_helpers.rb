# frozen_string_literal: true

module ValidationHelpers
  include Capybara::DSL

  def validate_values_match(expected, actual)
    expect(actual).to eq(expected), "Expected #{expected.inspect} but got #{actual.inspect}"
  end

  def validate_value_contains(expected, actual)
    expect(actual).to include(expected), "Expected #{actual.inspect} to include #{expected.inspect}"
  end

  def wait_for_heading_includes(element, expected, timeout: 10)
    expect(element).to have_text(expected, wait: timeout)
    true
  rescue Capybara::ExpectationNotMet
    raise "Timed out after #{timeout}s waiting for heading to include #{expected.inspect}"
  end
end
