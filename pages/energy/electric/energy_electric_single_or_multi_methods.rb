# frozen_string_literal: true

require "date"
require "pages/energy/energy_base_page"
require "components/energy/electric/energy_electric_single_or_multi_meter_comps"
require "components/energy/electric/energy_electric_meter_detail_comps"

class EnergyElectricSingleOrMultiMethods < EnergyBasePage
  def single_or_multi_option(choice)
    expect(page).to have_current_path(%r{/electricity-multi-single}, url: true, wait: 10)
    expect(energy_electric_single_or_multi_meter_comps.text_page_heading.text).to include("Is this a single or multi meter site?")
    case choice
    when "Single meter"
      energy_electric_single_or_multi_meter_comps.radio_single.click
    when "Multi meter"
      energy_electric_single_or_multi_meter_comps.radio_multi.click
    else
      raise ArgumentError, "Was expecting 'Single meter' or 'Multi meter' to be chosen and received '#{choice}'"
    end

    # Add to case state
    case_state.electric_single_or_multi_meter = choice
  end

  def continue_to_electricity_meter_details
    energy_electric_single_or_multi_meter_comps.button_save_and_continue.click
    expect(page).to have_current_path(%r{/electricity-meter/}, url: true, wait: 10)
    expect(energy_electric_meter_detail_comps.text_page_heading.text).to include("Electricity meter details")
  end
end
