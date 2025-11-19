# frozen_string_literal: true

require "date"
require "pages/energy/energy_base_page"
require "helpers/unique_content_helpers"
require "components/energy/electric/energy_electric_meter_detail_comps"
require "components/energy/electric/energy_electric_mpan_summary_comps"

class EnergyElectricMeterDetailsMethods < EnergyBasePage
  include UniqueContentHelpers

  def complete_and_submit_form(half_hourly)
    max_attempts = 10
    attempt = 0
    unique_number = nil
    electric_usage = nil

    while attempt < 10
      attempt += 1
      puts "[INFO] Attempt #{attempt}/#{max_attempts} to generate and submit a unique MPAN number"

      # Generate and fill form data
      unique_number = _add_unique_mpan_number
      electric_usage = _add_random_annual_electric_usage
      if half_hourly == "yes"
        energy_electric_meter_detail_comps.radio_half_hour_yes.click
        energy_electric_meter_detail_comps.input_half_hour_yes_kva.set(_add_random_annual_electric_usage)
        energy_electric_meter_detail_comps.input_half_hour_yes_data_aggregator.set("auto data aggregator #{generate_random_alpha_string(6)}")
        energy_electric_meter_detail_comps.input_half_hour_yes_data_collector.set("auto data collector #{generate_random_alpha_string(6)}")
        energy_electric_meter_detail_comps.input_half_hour_yes_meter_operator.set("auto data operator #{generate_random_alpha_string(6)}")
      else
        energy_electric_meter_detail_comps.radio_half_hour_no.click
      end

      energy_electric_meter_detail_comps.button_save_and_continue.click

      # Check if the duplicate MPAN error has been triggered!
      if energy_electric_meter_detail_comps.error_summary_present?(wait: 0.5)
        puts "[WARN] MPAN #{unique_number} already in use. Retrying..."
        next
      end

      # If no error, success — break out of the loop
      puts "[INFO] MPAN #{unique_number} accepted"
      break
    end

    # After 10 failed attempts, raise an error
    if attempt == max_attempts
      raise "AUTO ERROR: Could not generate a unique MPAN number after #{max_attempts} attempts"
    end

    # Based on it getting this far, we should infact be on the next page which could be one of many depending on the flow choice
    # For exmaple it could be /site-contact or MPAN Summart etc


    # Add to case state
    _add_next_available_mpan(unique_number, electric_usage)
  end

private

  def _add_unique_mpan_number
    number = generate_random_number(13, preserve_leading_zeros: true)
    field  = energy_electric_meter_detail_comps.input_mpan
    field.set("")
    field.set(number)
    number # <-- return the string, not the element
  end

  def _add_random_annual_electric_usage
    usage = generate_random_number(5, preserve_leading_zeros: true)
    field = energy_electric_meter_detail_comps.input_kwh
    field.set("")
    field.set(usage)
    usage # <-- return the string
  end

  # Add an MPAN/usage pair into the first available slot (1–5)
  def _add_next_available_mpan(mpan_number, usage)
    (1..5).each do |i|
      number_field = :"electric_mpan_number_#{i}"
      next unless case_state.send(number_field).to_s.strip.empty?

      case_state.send("#{number_field}=", mpan_number)
      case_state.send("electric_mpan_usage_#{i}=", usage)
      puts "[INFO] Added MPAN #{mpan_number} (#{usage} kWh) to slot #{i}"
      return i
    end

    raise "AUTO ERROR: All MPAN slots (1–5) already used"
  end
end
