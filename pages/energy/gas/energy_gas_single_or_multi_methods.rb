# frozen_string_literal: true

require "date"
require "pages/energy/energy_base_page"
require "components/energy/gas/energy_gas_single_or_multi_meter_comps"
require "components/energy/gas/energy_gas_meter_detail_comps"

class EnergyGasSingleOrMultiMethods < EnergyBasePage
  def single_or_multi_option(choice)
    expect(page).to have_current_path(%r{/gas-multi-single}, url: true, wait: 10)
    expect(energy_gas_single_or_multi_meter_comps.text_page_heading.text).to include("Is this a single or multi meter site?")
    case choice
    when "Single meter"
      energy_gas_single_or_multi_meter_comps.radio_single.click
    when "Multi meter"
      energy_gas_single_or_multi_meter_comps.radio_multi.click
    else
      raise ArgumentError, "Was expecting 'Single meter' or 'Multi meter' to be chosen and received '#{choice}'"
    end

    # Add to case state
    case_state.gas_single_or_multi_meter = choice
  end

  def continue_to_gas_meter_details
    energy_gas_single_or_multi_meter_comps.button_save_and_continue.click
    expect(page).to have_current_path(%r{/gas-meter}, url: true, wait: 10)
    expect(energy_gas_meter_detail_comps.text_page_heading.text).to include("Gas meter details")
  end
end
