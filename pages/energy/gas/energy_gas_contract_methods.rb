# frozen_string_literal: true

require "date"
require "pages/energy/energy_base_page"
require "components/energy/gas/energy_gas_contract_comps"

class EnergyGasContractMethods < EnergyBasePage

  def who_currently_supplies_your_gas(supplier)
    # Confirm we are on the page as we couldn't do this on the prev screen
    expect(page).to have_current_path(%r{/gas-contract}, url: true, wait: 10)
    expect(dfe_signin_enter_your_password_page_comps.text_page_heading.text).to include("Gas contract")

    case supplier
    when "British Gas"
      energy_gas_contract_comps.radio_supplier_british_gas.click
    when "EDF Energy"
      energy_gas_contract_comps.radio_supplier_edf_energy.click
    when "E.ON Next"
      energy_gas_contract_comps.radio_supplier_eon_next.click
    when "Scottish Power"
      energy_gas_contract_comps.radio_supplier_scottish_power.click
    when "OVO Energy"
      energy_gas_contract_comps.radio_supplier_ovo_energy.click
    when "Octopus Energy"
      energy_gas_contract_comps.radio_supplier_octopus_energy.click
    when "Other"
      energy_gas_contract_comps.radio_supplier_other.click
      energy_gas_contract_comps.input_other.set("A custom auto supplier")
    else
      # if the option is incorrectly typed in, fall back to british gas
      energy_gas_contract_comps.radio_supplier_british_gas.click
    end

  end

  def when_does_the_contract_end
    # get today's date + 60 days
    future_date = Date.today + 60

    # extract individual parts
    day   = future_date.day.to_s
    month = future_date.month.to_s
    year  = future_date.year.to_s

    # set each field on the page
    energy_gas_contract_comps.input_contract_end_day.set(day)
    energy_gas_contract_comps.input_contract_end_month.set(month)
    energy_gas_contract_comps.input_contract_end_year.set(year)
  end

  def continue_to_your_chosen_selection_path
    # Dependent on their choice they could be sent to Is this a single or multi meter site or Electricity contract
    energy_gas_contract_comps.button_save_and_continue.click
  end

end
