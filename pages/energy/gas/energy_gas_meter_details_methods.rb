# frozen_string_literal: true

require "date"
require "pages/energy/energy_base_page"
require "helpers/unique_content_helpers"
require "components/energy/gas/energy_gas_meter_detail_comps"
require "components/energy/gas/energy_gas_mprn_summary_comps"
require "components/energy/gas/energy_gas_remove_mprn_comps"
require "components/energy/electric/energy_electric_single_or_multi_meter_comps"
require "components/energy/gas/energy_gas_bill_consolidated_comps"
require "helpers/logger_helpers"
require "helpers/validation_helpers"

class EnergyGasMeterDetailsMethods < EnergyBasePage
  include UniqueContentHelpers
  include LoggerHelpers
  include ValidationHelpers

  def complete_and_submit_form
    generate_unique_mprn_number

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
    # _add_next_available_mprn(unique_number, gas_usage)

    # Axe Check
    axe_check! if FlagsGlobalConfig.axe_enabled?
  end

  def add_x_number_of_mprns_to_list(number_of_mprns)
    # Generate the first mprn number
    generate_unique_mprn_number

    # Now keep adding them till we hit our desired total
    (1..number_of_mprns).each do |_i|
      count_of_mprns = energy_gas_mprn_summary_comps.text_count_of_mprns.count

      if count_of_mprns < number_of_mprns
        energy_gas_mprn_summary_comps.button_add_another_mprn.click
        generate_unique_mprn_number
      end
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
  end

  def complete_the_reject_flow_for_the_last_mprn
    reject_the_latest_mprn
  end

  def reject_the_latest_mprn
    # Click remove on the last created MPRN
    latest_mprn = case_state.gas_mprn_number_2
    energy_gas_mprn_summary_comps.link_reject_specific_mprn(latest_mprn).click

    # Validate the correct reject screen has been loaded.
    expect(page).to have_current_path(%r{/remove-mprn/}, url: true, wait: 10)
    wait_for_element_to_include(energy_gas_remove_mprn_comps.text_page_heading, "Are you sure you want to remove the MPRN #{latest_mprn}?", timeout: 5)

    # Axe Check
    axe_check! if FlagsGlobalConfig.axe_enabled?

    # Remove the MPRN
    energy_gas_remove_mprn_comps.button_remove_mprn.click
    expect(page).to have_current_path(%r{/gas-meter-summary}, url: true, wait: 10)
    expect(energy_gas_mprn_summary_comps.text_page_heading.text).to include("MPRN summary")

    # Confirm notice is showing
    wait_for_element_to_include(energy_gas_mprn_summary_comps.text_flash_notice, "MPRN successfully removed", timeout: 5)

    # Set the second mprn case state to removed to allow handling later on in the flow
    case_state.gas_mprn_number_2 = "removed"
    case_state.gas_mprn_usage_2 = "removed"

    # Axe Check
    axe_check! if FlagsGlobalConfig.axe_enabled?
  end

  def continue_the_flow_after_rejecting_an_mprn
    # Validate were on the MPRN summary screen
    expect(page).to have_current_path(%r{/gas-meter-summary}, url: true, wait: 10)
    expect(energy_gas_mprn_summary_comps.text_page_heading.text).to include("MPRN summary")

    # continue the flow through the "Do you want your MPRNs consolidated on one bill" screen
    energy_gas_mprn_summary_comps.button_save_and_continue.click
    expect(page).to have_current_path(%r{/gas-bill}, url: true, wait: 10)
    wait_for_element_to_include(energy_gas_bill_consolidated_comps.text_page_heading, "Do you want your MPRNs consolidated on one bill?", timeout: 5)
    energy_gas_bill_consolidated_comps.radio_bill_yes.click
    energy_gas_bill_consolidated_comps.button_save_and_continue.click

    # Based on it getting this far, we should in fact be on the next page, however this page may vary based on the route chosen
    if case_state.energy_choice == "gas only"
      expect(page).to have_current_path(%r{/gas-meter-summary}, url: true, wait: 10)
      expect(energy_gas_mprn_summary_comps.text_page_heading.text).to include("MPRN summary")
    end

    if %w[both both_with_reject].include?(case_state.energy_choice)
      expect(page).to have_current_path(%r{/electricity-multi-single}, url: true, wait: 10)
      expect(energy_electric_single_or_multi_meter_comps.text_page_heading.text).to include("Is this a single or multi meter site?")
    end
  end

  def generate_unique_mprn_number
    max_attempts = 10
    attempt = 0
    unique_number = nil
    gas_usage = nil

    while attempt < 10
      attempt += 1
      log_info("Attempt #{attempt}/#{max_attempts} to generate and submit a unique MPRN number")

      # Generate and fill data
      unique_number = _add_unique_mprn_number
      gas_usage = _add_random_annual_gas_usage
      energy_gas_meter_detail_comps.button_save_and_continue.click

      # Check if the duplicate MPRN error has been triggered!
      if energy_gas_meter_detail_comps.error_summary_present?(wait: 0.5)
        log_warn("MPRN #{unique_number} already in use. Retrying...")
        next
      end

      # If no error, success — break out of the loop
      log_info("MPRN #{unique_number} accepted")
      break
    end

    # After 10 failed attempts, raise an error
    if attempt == max_attempts
      raise "AUTO ERROR: Could not generate a unique MPRN number after #{max_attempts} attempts"
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
      log_info("Added MPRN #{mprn_number} (#{usage} kWh) to slot #{i}")
      return i
    end

    raise "AUTO ERROR: All MPRN slots (1–5) already used"
  end
end
