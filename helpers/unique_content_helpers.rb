# frozen_string_literal: true

module UniqueContentHelpers
  include Capybara::DSL

  def generate_random_number(digits, preserve_leading_zeros: false)
    if preserve_leading_zeros
      # Generate as string, keep leading zeros
      "%0#{digits}d" % rand(0...(10**digits))
    else
      # Generate as integer (no leading zeros)
      rand(10**(digits - 1)..(10**digits - 1))
    end
  end
end
