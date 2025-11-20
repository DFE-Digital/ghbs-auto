# frozen_string_literal: true

module UniqueContentHelpers
  include Capybara::DSL

  def generate_random_number(digits, preserve_leading_zeros: false)
    if preserve_leading_zeros
      # Generate as string, keep leading zeros
      sprintf("%0#{digits}d", rand(0...(10**digits)))
    else
      # Generate as integer (no leading zeros)
      rand(10**(digits - 1)..(10**digits - 1))
    end
  end

  def generate_random_number_in_range(min, max, preserve_leading_zeros: false)
    raise ArgumentError, "min must be <= max" if min > max

    number = rand(min..max)

    if preserve_leading_zeros
      # Pad with zeros up to the same length as the larger bound
      max_length = max.to_s.length
      sprintf("%0#{max_length}d", number)
    else
      number
    end
  end

  def generate_random_alpha_string(length)
    chars = ("A".."Z").to_a + ("a".."z").to_a
    Array.new(length) { chars.sample }.join
  end
end
