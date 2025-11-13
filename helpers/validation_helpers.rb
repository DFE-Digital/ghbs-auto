# frozen_string_literal: true

module ValidationHelpers
  include Capybara::DSL

  def validate_values_match(expected, actual)
    expect(actual).to eq(expected), "Expected #{expected.inspect} but got #{actual.inspect}"
  end
end
