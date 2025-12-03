# frozen_string_literal: true

module ContentFormatHelpers
  def format_currency(value)
    return "£0.00" if value.nil?

    num = value.to_f
    sprintf("£%0.2f", num).gsub(/(\d)(?=(\d{3})+\.)/, '\1,')
  end
end
