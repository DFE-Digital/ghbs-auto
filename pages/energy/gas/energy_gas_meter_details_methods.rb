# frozen_string_literal: true

require "date"
require "pages/energy/energy_base_page"
require "helpers/unique_content_helpers"
require "components/energy/gas/energy_gas_meter_detail_comps"
require "components/energy/gas/energy_gas_mprn_summary_comps"
require "components/energy/electric/energy_electric_single_or_multi_meter_comps"

class EnergyGasMeterDetailsMethods < EnergyBasePage
  include UniqueContentHelpers

  def complete_and_submit_form
    max_attempts = 10
    attempt = 0
    unique_number = nil
    gas_usage = nil

    while attempt < 10
      attempt += 1
      puts "[INFO] Attempt #{attempt}/#{max_attempts} to generate and submit a unique MPRN number"

      # Generate and fill data
      unique_number = _add_unique_mprn_number
      gas_usage = _add_random_annual_gas_usage
      energy_gas_meter_detail_comps.button_save_and_continue.click

      # Check if the duplicate MPRN error has been triggered!
      if energy_gas_meter_detail_comps.error_summary_present?(wait: 0.5)
        puts "[WARN] MPRN #{unique_number} already in use. Retrying..."
        next
      end

      # If no error, success — break out of the loop
      puts "[INFO] MPRN #{unique_number} accepted"
      break
    end

    # After 10 failed attempts, raise an error
    if attempt == max_attempts
      raise "AUTO ERROR: Could not generate a unique MPRN number after #{max_attempts} attempts"
    end

    # Based on it getting this far, we should in fact be on the next page, however this page may vary based on the route chosen
    if case_state.energy_choice == "gas only"
      expect(page).to have_current_path(%r{/gas-meter-summary}, url: true, wait: 10)
      expect(energy_gas_mprn_summary_comps.text_page_heading.text).to include("MPRN summary")
    end

    if case_state.energy_choice == "both"
      expect(page).to have_current_path(%r{/electricity-multi-single}, url: true, wait: 10)
      expect(energy_electric_single_or_multi_meter_comps.text_page_heading.text).to include("Is this a single or multi meter site?")
    end

    # Add to case state
    _add_next_available_mprn(unique_number, gas_usage)
  end

private

  def _add_unique_mprn_number
    number = generate_random_number(12, preserve_leading_zeros: true)
    field  = energy_gas_meter_detail_comps.input_mprn
    field.set("")
    field.set(number)
    number # <-- return the string, not the element
  end

  def _add_random_annual_gas_usage
    usage = generate_random_number(5, preserve_leading_zeros: true)
    field = energy_gas_meter_detail_comps.input_kwh
    field.set("")
    field.set(usage)
    usage # <-- return the string
  end

  # Add an MPRN/usage pair into the first available slot (1–5)
  def _add_next_available_mprn(mprn_number, usage)
    (1..5).each do |i|
      number_field = :"gas_mprn_number_#{i}"
      next unless case_state.send(number_field).to_s.strip.empty?

      case_state.send("#{number_field}=", mprn_number)
      case_state.send("gas_mprn_usage_#{i}=", usage)
      puts "[INFO] Added MPRN #{mprn_number} (#{usage} kWh) to slot #{i}"
      return i
    end

    raise "AUTO ERROR: All MPRN slots (1–5) already used"
  end
end
