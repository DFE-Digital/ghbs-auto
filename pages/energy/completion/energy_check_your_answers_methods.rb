# frozen_string_literal: true

require "pages/energy/energy_base_page"
require "components/energy/completion/energy_check_your_answers_comps"
require "components/energy/completion/energy_loa_comps"
require "helpers/validation_helpers"
class EnergyCheckYourAnswersMethods < EnergyBasePage
  include ValidationHelpers

  def validate_all_sections
    if case_state.energy_choice == "electric only"
      validate_current_electric_contract_details
      validate_electric_meters_and_usage
      validate_site_contact_details
      validate_vat_declaration
      validate_billing_preferences
    end

    if case_state.energy_choice == "gas only"
      validate_current_gas_contract_details
      validate_gas_meters_and_usage
      validate_site_contact_details
      validate_vat_declaration
      validate_billing_preferences
    end

    if case_state.energy_choice == "both"
      # TODO: add the logic for the 'both' case
    end
  end

  def validate_current_gas_contract_details
    validate_values_match(case_state.gas_current_supplier, energy_check_your_answers_comps.text_current_gas_supplier.text)
    validate_values_match(case_state.gas_current_contract_end_date, energy_check_your_answers_comps.text_when_does_your_gas_contract_end.text)
  end

  def validate_current_electric_contract_details
    validate_values_match(case_state.electric_current_supplier, energy_check_your_answers_comps.text_current_electric_supplier.text)
    validate_values_match(case_state.electric_current_contract_end_date, energy_check_your_answers_comps.text_when_does_your_electric_contract_end.text)
  end

  def validate_gas_meters_and_usage
    validate_values_match(case_state.gas_single_or_multi_meter, energy_check_your_answers_comps.text_gas_single_or_multi_meter.text)
    validate_values_match(case_state.gas_mprn_number_1, energy_check_your_answers_comps.text_gas_meter_point_reference_number_1.text)
    validate_values_match(case_state.gas_mprn_usage_1, energy_check_your_answers_comps.text_gas_estimated_annual_gas_usage_1.text)
  end

  def validate_electric_meters_and_usage
    validate_values_match(case_state.electric_single_or_multi_meter, energy_check_your_answers_comps.text_electric_single_or_multi_meter.text)

    validate_values_match(case_state.electric_mpan_number_1, energy_check_your_answers_comps.text_electric_mpan_number_1.text)
    validate_values_match(case_state.electric_mpan_half_hourly_meter_1, energy_check_your_answers_comps.text_electric_is_this_half_hour_1.text)
    validate_values_match(case_state.electric_mpan_usage_kwh_1, energy_check_your_answers_comps.text_electric_estimated_annual_usage_kwh_1.text)

    validate_values_match(case_state.electric_mpan_half_hourly_meter_kva_1, energy_check_your_answers_comps.text_electric_supply_capacity_1.text)
    validate_values_match(case_state.electric_mpan_half_hourly_meter_data_aggregator_1, energy_check_your_answers_comps.text_electric_data_aggregator_1.text)
    validate_values_match(case_state.electric_mpan_half_hourly_meter_data_collector_1, energy_check_your_answers_comps.text_electric_data_collector_1.text)
    validate_values_match(case_state.electric_mpan_half_hourly_meter_meter_operator_1, energy_check_your_answers_comps.text_electric_meter_operator_1.text)
  end

  def validate_site_contact_details
    full_name = "#{case_state.site_contact_first_name} #{case_state.site_contact_last_name}"

    validate_values_match(full_name, energy_check_your_answers_comps.text_site_contact_name.text)
    validate_values_match(case_state.site_contact_email, energy_check_your_answers_comps.text_site_contact_email.text)
    validate_values_match(case_state.site_contact_phone, energy_check_your_answers_comps.text_site_contact_phone.text)
  end

  def validate_vat_declaration
    validate_values_match(case_state.vat_rate, energy_check_your_answers_comps.text_vat_rate.text)
    #  :vat_qualifying_percentage,
    #  :vat_reg_number,
    #  :vat_contact_name,
    #  :vat_contact_phone,
    #  :vat_contact_address,
    #  :vat_certificate_confirmation,
  end

  def validate_billing_preferences
    validate_values_match(case_state.billing_how_paid, energy_check_your_answers_comps.text_billing_how_will_you_pay.text)
    validate_values_match(case_state.billing_payment_terms, energy_check_your_answers_comps.text_billing_payment_terms.text)
    validate_values_match(case_state.billing_how_receive, energy_check_your_answers_comps.text_billing_how_would_you_like_to_receive.text)
    validate_value_contains(energy_check_your_answers_comps.text_billing_address.text, case_state.billing_address)
  end

  def continue_to_loa_page
    energy_check_your_answers_comps.button_continue.click
    expect(page).to have_current_path(%r{/letter-of-authority}, url: true, wait: 10)
    expect(energy_loa_comps.text_page_heading.text).to include("Agree to the Energy for Schools letter of authority")
  end
end
