# frozen_string_literal: true

require "date"
require "pages/energy/energy_base_page"
require "components/energy/electric/energy_electric_meter_detail_comps"
require "components/energy/electric/energy_electric_mpan_summary_comps"
require "components/energy/electric/energy_electric_bill_consolidated_comps"
require "components/energy/site_access/energy_site_access_comps"
require "components/energy/electric/energy_electric_remove_mpan_comps"
require "helpers/unique_content_helpers"
require "helpers/validation_helpers"

class EnergyElectricMeterDetailsMethods < EnergyBasePage
  include UniqueContentHelpers
  include ValidationHelpers

  def complete_and_submit_form(half_hourly)
    add_x_number_of_mpans_to_list(1, half_hourly)
  end

  def add_x_number_of_mpans_to_list(number_of_mpans, half_hourly)
    # Generate the first mpan number, we always need at least 1
    generate_unique_mpan_number(half_hourly)

    # Now it gets more complicated. Dependent on single or multi will completely change the flow.
    if case_state.electric_single_or_multi_meter == "Multi meter"
      # Now keep adding them till we hit our desired total
      (1..number_of_mpans).each do |_i|
        count_of_mprns = energy_electric_mpan_summary_comps.text_count_of_mpans.count

        if count_of_mprns < number_of_mpans
          energy_electric_mpan_summary_comps.button_add_another_mpan.click
          generate_unique_mpan_number(half_hourly)
        end
      end
    end

    if case_state.electric_single_or_multi_meter == "Single meter"
      # Based on it getting this far, we should in fact be on the next page, however this page may vary based on the route chosen
      expect(page).to have_current_path(%r{/site-contact}, url: true, wait: 10)
      expect(energy_site_access_comps.text_page_heading.text).to include("Who manages site access and maintenance?")
    end
  end

  def generate_unique_mpan_number(half_hourly_meter)
    max_attempts = 10
    attempt = 0
    unique_mpan_number = nil

    while attempt < 10
      attempt += 1
      log_info("Attempt #{attempt}/#{max_attempts} to generate and submit a unique MPAN number")

      # Generate and fill form data
      unique_mpan_number = _add_unique_mpan_number
      electric_usage_kwh = _add_random_annual_electric_usage_kwh
      electric_usage_kva = ""
      data_aggregator = ""
      data_collector = ""
      meter_operator = ""

      if half_hourly_meter == "yes"
        # Select option Yes
        energy_electric_meter_detail_comps.radio_half_hour_yes.click
        case_state.electric_mpan_half_hourly_meter_1 = "Yes"

        # Input kva
        electric_usage_kva = _add_random_annual_electric_usage_kva
        energy_electric_meter_detail_comps.input_half_hour_yes_kva.set(electric_usage_kva)

        # Input data aggregator
        data_aggregator = "auto data aggregator #{generate_random_alpha_string(6)}"
        energy_electric_meter_detail_comps.input_half_hour_yes_data_aggregator.set(data_aggregator)

        # Input data collector
        data_collector = "auto data collector #{generate_random_alpha_string(6)}"
        energy_electric_meter_detail_comps.input_half_hour_yes_data_collector.set(data_collector)

        # Input data operator
        meter_operator = "auto data operator #{generate_random_alpha_string(6)}"
        energy_electric_meter_detail_comps.input_half_hour_yes_meter_operator.set(meter_operator)
      else
        energy_electric_meter_detail_comps.radio_half_hour_no.click
        case_state.electric_mpan_half_hourly_meter_1 = "No"
      end

      energy_electric_meter_detail_comps.button_save_and_continue.click

      # Check if the duplicate MPAN error has been triggered!
      if energy_electric_meter_detail_comps.error_summary_present?(wait: 0.5)
        log_warn("MPAN #{unique_mpan_number} already in use. Retrying...")
        next
      end

      # If no error, success — break out of the loop
      log_info("MPAN #{unique_mpan_number} accepted")
      break
    end

    # After 10 failed attempts, raise an error
    if attempt == max_attempts
      raise "AUTO ERROR: Could not generate a unique MPAN number after #{max_attempts} attempts"
    end

    # Based on it getting this far, we should in fact be on the next page which could be one of many depending on the flow choice, For example it could be /site-contact or MPAN Summary etc.
    # Add to case state
    _add_next_available_case_state_electric_data_slot(unique_mpan_number, half_hourly_meter, electric_usage_kwh, electric_usage_kva, data_aggregator, data_collector, meter_operator)

    # Axe Check
    axe_check! if FlagsGlobalConfig.axe_enabled?
  end

  def complete_the_reject_flow_for_the_last_mprn
    reject_the_latest_mprn
  end

  def reject_the_latest_mpan
    # Click remove on the last created MPAN
    latest_mpan = case_state.electric_mpan_number_2
    energy_electric_mpan_summary_comps.link_reject_specific_mprn(latest_mpan).click

    # Validate the correct reject screen has been loaded.
    expect(page).to have_current_path(%r{/remove-mpan/}, url: true, wait: 10)
    wait_for_element_to_include(energy_electric_remove_mpan_comps.text_page_heading, "Are you sure you want to remove the MPAN #{latest_mpan}?", timeout: 5)

    # Axe Check
    axe_check! if FlagsGlobalConfig.axe_enabled?

    # Remove the MPRN
    energy_electric_remove_mpan_comps.button_remove_mpan.click
    expect(page).to have_current_path(%r{/electricity-meter-summary}, url: true, wait: 10)
    expect(energy_electric_mpan_summary_comps.text_page_heading.text).to include("MPAN summary")

    # Confirm notice is showing
    wait_for_element_to_include(energy_electric_mpan_summary_comps.text_flash_notice, "MPAN successfully removed", timeout: 5)

    # Set the second mpan case state to removed to allow handling later on in the flow
    case_state.electric_mpan_number_2 = "removed"
    case_state.electric_mpan_half_hourly_meter_2 = "removed"
    case_state.electric_mpan_half_hourly_meter_kva_2 = "removed"
    case_state.electric_mpan_half_hourly_meter_data_aggregator_2 = "removed"
    case_state.electric_mpan_half_hourly_meter_data_collector_2 = "removed"
    case_state.electric_mpan_half_hourly_meter_meter_operator_2 = "removed"
    case_state.electric_mpan_usage_kwh_2 = "removed"

    # Axe Check
    axe_check! if FlagsGlobalConfig.axe_enabled?
  end

  def continue_the_flow_after_rejecting_an_mpan
    # Validate were on the MPRN summary screen
    expect(page).to have_current_path(%r{/electricity-meter-summary}, url: true, wait: 10)
    expect(energy_electric_mpan_summary_comps.text_page_heading.text).to include("MPAN summary")

    # continue the flow through the "Do you want your MPANs consolidated on one bill?" screen
    energy_electric_mpan_summary_comps.button_save_and_continue.click
    expect(page).to have_current_path(%r{/electricity-bill}, url: true, wait: 10)
    wait_for_element_to_include(energy_electric_bill_consolidated_comps.text_page_heading, "Do you want your MPANs consolidated on one bill?", timeout: 5)

    # continue on to the site access screen
    energy_electric_bill_consolidated_comps.radio_bill_yes.click
    case_state.electric_mpan_consolidated_bill = "Yes"
    energy_electric_bill_consolidated_comps.button_save_and_continue.click
    expect(page).to have_current_path(%r{/site-contact}, url: true, wait: 10)
    wait_for_element_to_include(energy_site_access_comps.text_page_heading, "Who manages site access and maintenance?", timeout: 5)
  end

private

  def _add_unique_mpan_number
    number = generate_random_number(13, preserve_leading_zeros: true)
    field  = energy_electric_meter_detail_comps.input_mpan
    field.set("")
    field.set(number)
    number # <-- return the string, not the element
  end

  def _add_random_annual_electric_usage_kwh
    usage = generate_random_number(5, preserve_leading_zeros: true)
    field = energy_electric_meter_detail_comps.input_kwh
    field.set("")
    field.set(usage)
    usage # <-- return the string
  end

  def _add_random_annual_electric_usage_kva
    usage = generate_random_number(5, preserve_leading_zeros: true)
    field = energy_electric_meter_detail_comps.input_half_hour_yes_kva
    field.set("")
    field.set(usage)
    usage # <-- return the string
  end

  # Add an MPAN/usage pair into the first available slot (1–5)
  def _add_next_available_case_state_electric_data_slot(unique_mpan_number, half_hourly_meter, electric_usage_kwh, electric_usage_kva, data_aggregator, data_collector, meter_operator)
    (1..5).each do |i|
      number_field = :"electric_mpan_number_#{i}"
      next unless case_state.send(number_field).to_s.strip.empty?

      case_state.send("#{number_field}=", unique_mpan_number)
      case_state.send("electric_mpan_half_hourly_meter_#{i}=", half_hourly_meter)
      case_state.send("electric_mpan_usage_kwh_#{i}=", electric_usage_kwh)
      case_state.send("electric_mpan_half_hourly_meter_kva_#{i}=", electric_usage_kva)
      case_state.send("electric_mpan_half_hourly_meter_data_aggregator_#{i}=", data_aggregator)
      case_state.send("electric_mpan_half_hourly_meter_data_collector_#{i}=", data_collector)
      case_state.send("electric_mpan_half_hourly_meter_meter_operator_#{i}=", meter_operator)

      return i
    end

    raise "AUTO ERROR: All MPAN slots (1–5) already used"
  end
end
