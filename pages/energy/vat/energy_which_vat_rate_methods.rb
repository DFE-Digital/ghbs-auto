# frozen_string_literal: true

require "date"
require "pages/energy/energy_base_page"
require "helpers/unique_content_helpers"
require "components/energy/vat/energy_which_vat_rate_comps"

class EnergyWhichVatRateMethods < EnergyBasePage
  include UniqueContentHelpers

  def complete_with_20_percentage_vat
    energy_which_vat_rate_comps.radio_20_percent.click
  end

  def complete_with_5_percentage_vat
    energy_which_vat_rate_comps.radio_5_percent.click
    # Percentage of total consumption qualifying for reduced rate of VAT
    energy_which_vat_rate_comps.input_total_consumption_percent.set(generate_random_number_in_range(1, 100, preserve_leading_zeros: false))
    # VAT registration number (optional)
    energy_which_vat_rate_comps.input_vat_reg_number.set(generate_random_number(9, preserve_leading_zeros: true))
  end

  def continue_to_next_page_based_on_choice
    # Depending on their choice, 20% would take them to Billing and 5% would take them too more VAT screens
    energy_which_vat_rate_comps.button_save_and_continue.click
  end

end
