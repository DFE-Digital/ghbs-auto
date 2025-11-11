# frozen_string_literal: true

require "date"
require "pages/energy/energy_base_page"
require "components/energy/gas/energy_gas_single_or_multi_meter_comps"
require "components/energy/gas/energy_gas_meter_detail_comps"

class EnergyGasSingleOrMultiMethods < EnergyBasePage
  def single_or_multi_option(choice)
    expect(page).to have_current_path(%r{/gas-multi-single}, url: true, wait: 10)
    expect(energy_what_are_you_switching_comps.text_page_heading.text).to include("Is this a single or multi meter site?")
    case choice
    when "single"
      energy_gas_single_or_multi_meter_comps.radio_single.click
    when "multi"
      energy_gas_single_or_multi_meter_comps.radio_multi.click
    else
      # if the option is incorrectly typed in, fall back to single
      energy_gas_contract_comps.radio_supplier_british_gas.click
    end
  end

  def continue_to_gas_meter_details
    energy_gas_contract_comps.button_save_and_continue.click
    expect(page).to have_current_path(%r{/gas-meter}, url: true, wait: 10)
    expect(energy_gas_meter_detail_comps.text_page_heading.text).to include("Gas meter details")
  end
end
