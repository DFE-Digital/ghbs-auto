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

  # Are you switching electricity, gas or both?
  energy_switching_selection_methods.choose_switch(switching_method)
  energy_switching_selection_methods.continue_to_your_chosen_selection_path

  case switching_method
  when "gas only"
    # Gas contract
    energy_gas_contract_methods.who_currently_supplies_your_gas("Other")
    energy_gas_contract_methods.when_does_the_contract_end
    energy_gas_contract_methods.continue_to_your_chosen_selection_path
    # Is this a single or multi meter site?
    energy_gas_single_or_multi_methods.single_or_multi_option("single")
    energy_gas_single_or_multi_methods.continue_to_gas_meter_details
    # Gas meter details
    energy_gas_meter_details_methods.complete_and_submit_form
    # MPRN summary
    energy_gas_mprn_summary_methods.continue_to_gas_bill_consolidated
    # Do you want your MPRNs consolidated on one bill?
    energy_gas_mprn_consolidated_methods.bills_consolidated_yes
    energy_gas_mprn_consolidated_methods.continue_to_next_screen_based_on_flow
    # Who manages site access and maintenance?
    energy_site_access_methods.complete_with_unique_data
    energy_site_access_methods.continue_to_which_vat_rate_page
    # Which VAT rate are you charged?
    energy_which_vat_rate_methods.complete_with_20_percentage_vat
    energy_which_vat_rate_methods.continue_to_next_page_based_on_choice
    # Billing preferences
    # Billing address
    # Check your answers
    # Agree to the Energy for Schools letter of authority
  when "electricity only"
    # TODO: electricity flow
  when "both"
    # TODO: gas flow then electricity
  end
end
