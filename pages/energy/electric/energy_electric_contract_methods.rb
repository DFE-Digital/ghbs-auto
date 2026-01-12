# frozen_string_literal: true

require "date"
require "pages/energy/energy_base_page"
require "components/energy/electric/energy_electric_contract_comps"

class EnergyElectricContractMethods < EnergyBasePage
  def who_currently_supplies_your_electricity(supplier)
    # Confirm we are on the page as we couldn't do this on the prev screen
    expect(page).to have_current_path(%r{/electricity-contract}, url: true, wait: 10)
    expect(energy_electric_contract_comps.text_page_heading.text).to include("Electricity contract")

    other_option_custom_name = "A custom auto electric supplier"

    case supplier
    when "British Gas"
      energy_electric_contract_comps.radio_supplier_british_gas.click
    when "EDF Energy"
      energy_electric_contract_comps.radio_supplier_edf_energy.click
    when "E.ON Next"
      energy_electric_contract_comps.radio_supplier_eon_next.click
    when "Scottish Power"
      energy_electric_contract_comps.radio_supplier_scottish_power.click
    when "OVO Energy"
      energy_electric_contract_comps.radio_supplier_ovo_energy.click
    when "Octopus Energy"
      energy_electric_contract_comps.radio_supplier_octopus_energy.click
    when "Other"
      energy_electric_contract_comps.radio_supplier_other.click
      energy_electric_contract_comps.input_other.set(other_option_custom_name)
    else
      # if the option is incorrectly typed in, fall back to british gas
      energy_electric_contract_comps.radio_supplier_british_gas.click
    end

    # Add to case state
    case_state.electric_current_supplier = if supplier == "Other"
                                             other_option_custom_name
                                           else
                                             supplier
                                           end
  end

  def when_does_the_contract_end
    # get today's date + 60 days
    future_date = Date.today + 60

    # extract individual parts with leading zeros
    day   = sprintf("%02d", future_date.day)
    month = sprintf("%02d", future_date.month)
    year  = future_date.year.to_s

    # set each field on the page
    energy_electric_contract_comps.input_contract_end_day.set(day)
    energy_electric_contract_comps.input_contract_end_month.set(month)
    energy_electric_contract_comps.input_contract_end_year.set(year)

    # Add to case state
    case_state.electric_current_contract_end_date = "#{day}-#{month}-#{year}"
  end

  def continue_to_your_chosen_selection_path
    # Dependent on their choice they could be sent to Is this a single or multi meter site or Electricity contract
    energy_electric_contract_comps.button_save_and_continue.click
  end
end
