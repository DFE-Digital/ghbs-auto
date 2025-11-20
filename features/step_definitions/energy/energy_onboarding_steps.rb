# frozen_string_literal: true

Given("we open and validate the start of the energy onboarding flow") do
  energy_start_page_methods.open_energy_start_page
  energy_start_page_methods.validate_start_page_loaded
end

And(/^we select (.*) from the bullet list and start the onboarding journey$/) do |school_name|
  energy_school_selection_methods.select_school(school_name)
  energy_school_selection_methods.continue_to_are_you_authorised_page
end

When(/^the (.*) option is selected and completed$/) do |switching_method|
  energy_are_you_authorised_page_methods.continue_to_what_are_switching_page

  # Are you switching electric, gas or both?
  energy_switching_selection_methods.choose_switch(switching_method)
  energy_switching_selection_methods.continue_to_your_chosen_selection_path

  case switching_method
  when "gas only"
    # Gas contract
    energy_gas_contract_methods.who_currently_supplies_your_gas("Other")
    energy_gas_contract_methods.when_does_the_contract_end
    energy_gas_contract_methods.continue_to_your_chosen_selection_path
    # Is this a single or multi meter site?
    energy_gas_single_or_multi_methods.single_or_multi_option("Single meter")
    energy_gas_single_or_multi_methods.continue_to_gas_meter_details
    # Gas meter details
    energy_gas_meter_details_methods.complete_and_submit_form
    # MPRN summary
    energy_gas_mprn_summary_methods.continue_to_gas_bill_consolidated
    # Do you want your MPRNs consolidated on one bill?
    energy_gas_mprn_consolidated_methods.bills_consolidated_yes
    energy_gas_mprn_consolidated_methods.continue_to_next_screen_based_on_flow
  when "electric only"
    # Electric contract
    energy_electric_contract_methods.who_currently_supplies_your_electricity("Other")
    energy_electric_contract_methods.when_does_the_contract_end
    energy_electric_contract_methods.continue_to_your_chosen_selection_path
    # Is this a single or multi meter site?
    energy_electric_single_or_multi_methods.single_or_multi_option("Single meter")
    energy_electric_single_or_multi_methods.continue_to_electricity_meter_details
    # Gas meter details
    energy_electric_meter_details_methods.complete_and_submit_form("yes")
  when "both"
    # TODO: gas flow then electric
  else
    raise ArgumentError, "Was expecting 'gas only', 'electric only' or 'both' to be chosen but got '#{switching_method}'"
  end
end

And(/^the Site Contact screen is completed$/) do
  # Who manages site access and maintenance?
  energy_site_access_methods.complete_with_unique_data
  energy_site_access_methods.continue_to_which_vat_rate_page
end

And(/^the VAT flow is completed with a (.*) percent option selected$/) do |vat_percentage|
  # Which VAT rate are you charged?
  energy_which_vat_rate_methods.percentage_choice(vat_percentage)
  energy_which_vat_rate_methods.continue_to_next_page_based_on_choice
end

And(/^the Billing section is completed with the (.*) option selected$/) do |billing_option|
  # Billing preferences
  energy_billing_pref_methods.how_bills_paid(billing_option)
  energy_billing_pref_methods.payment_terms("14")
  energy_billing_pref_methods.how_to_invoice("paper")
  energy_billing_pref_methods.continue_to_billing_address_page
  # Billing address
  energy_billing_address_methods.choose_address_in_position("1")
  energy_billing_address_methods.continue_to_check_your_answers
end

And(/^the CYA screen info is validated$/) do
  # Check your answers
  energy_check_your_answers_methods.validate_all_sections
  energy_check_your_answers_methods.continue_to_loa_page
  # Agree to the Energy for Schools letter of authority
end

Then(/^we complete the form and confirm our newly created case number$/) do
  # Letter Of Agreement
  energy_loa_methods.complete_loa
  energy_loa_methods.continue_to_information_submitted
  # Information submitted on 13 November 2025
  energy_info_submitted_methods.validate_information_date_is_today
end
