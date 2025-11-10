# frozen_string_literal: true

require "date"
require "pages/energy/energy_base_page"
require "helpers/unique_content_helpers"
require "components/energy/gas/energy_gas_meter_detail_comps"

class EnergyGasMeterDetailsMethods < EnergyBasePage
  include UniqueContentHelpers

  def complete_and_submit_form
    max_attempts = 10
    attempt = 0
    unique_number = nil

    while attempt < 10
      attempt += 1
      puts "[INFO] Attempt #{attempt}/#{max_attempts} to generate and submit a unique MPRN number"

      # Generate and fill data
      unique_number = _add_unique_mprn_number
      _add_random_annual_gas_usage
      energy_gas_contract_comps.button_save_and_continue.click

      # Check if the duplicate MPRN error has been triggered!
      if energy_gas_meter_detail_comps.error_summary_present?(wait: 0.5)
        puts "[WARN] Number #{unique_number} already in use. Retrying..."
        next
      end

      # If no error, success — break out of the loop
      puts "[INFO] Number #{unique_number} accepted"
      break
    end

    # After 10 failed attempts, raise an error
    if attempt == max_attempts
      raise "AUTO ERROR: Could not generate a unique MPRN number after #{max_attempts} attempts"
    end

    # Based on it getting this far, we should infact be on the next page
    expect(page).to have_current_path(%r{/gas-meter-summary}, url: true, wait: 10)
    expect(energy_what_are_you_switching_comps.text_page_heading.text).to include("MPRN summary")
  end

private

  def _add_unique_mprn_number
    # Add the Meter Point Reference Number (MPRN)
    unique_number = generate_random_number(12, preserve_leading_zeros: true)
    energy_gas_meter_detail_comps.input_mprn.set('')
    energy_gas_meter_detail_comps.input_mprn.set(unique_number)
  end

  def _add_random_annual_gas_usage
    # Estimated annual gas usage for this meter, in kilowatt hours (kWh)
    unique_number = generate_random_number(5, preserve_leading_zeros: true)
    energy_gas_meter_detail_comps.input_kwh.set('') # clear the field (Ruby doesn't have .Clear logic as standard)
    energy_gas_meter_detail_comps.input_kwh.set(unique_number)
  end

end
