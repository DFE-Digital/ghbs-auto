# frozen_string_literal: true

require "pages/energy/energy_base_page"
require "components/energy/completion/energy_check_your_answers_comps"
require "components/energy/completion/energy_loa_comps"
require "helpers/validation_helpers"
class EnergyCheckYourAnswersMethods < EnergyBasePage
  include ValidationHelpers

  def validate_all_sections
    validate_current_contract_details
    validate_gas_meters_and_usage
    validate_site_contact_details
    validate_vat_declaration
    validate_billing_preferences
  end

  def validate_current_contract_details
    validate_values_match(case_state.gas_current_supplier, energy_check_your_answers_comps.text_current_gas_supplier.text)
    validate_values_match(case_state.gas_current_contract_end_date, energy_check_your_answers_comps.text_when_does_your_contract_end.text)
  end

  def validate_gas_meters_and_usage
    validate_values_match(case_state.gas_single_or_multi_meter, energy_check_your_answers_comps.text_gas_single_or_multi_meter.text)
    validate_values_match(case_state.gas_mprn_number_1, energy_check_your_answers_comps.text_gas_meter_point_reference_number_1.text)
    validate_values_match(case_state.gas_mprn_usage_1, energy_check_your_answers_comps.text_gas_estimated_annual_gas_usage_1.text)

    #  :gas_mprn_number_2,
    #  :gas_mprn_usage_2,
    #  :gas_mprn_number_3,
    #  :gas_mprn_usage_3,
    #  :gas_mprn_number_4,
    #  :gas_mprn_usage_4,
    #  :gas_mprn_number_5,
    #  :gas_mprn_usage_5,
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
