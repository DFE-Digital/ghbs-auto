# frozen_string_literal: true

require "pages/shared/shared_global_methods"
require "pages/rfh/rfh_base_page"
require "components/rfh/school_selection/rfh_what_type_of_org_comps"
require "components/rfh/school_selection/rfh_search_for_your_school_comps"
require "components/rfh/school_selection/rfh_search_for_an_academy_trust_comps"
require "components/rfh/school_selection/rfh_is_this_the_school_your_buying_for_comps"
require "components/rfh/school_selection/rfh_if_this_the_academy_trust_your_buying_for_comps"
require "components/rfh/school_selection/rfh_which_school_in_your_academy_comps"
require "components/rfh/school_selection/rfh_are_these_the_schools_your_buying_for_comps"
require "components/rfh/about_you/rfh_what_is_your_name_comps"
require "components/rfh/about_you/rfh_what_is_your_email_comps"
require "helpers/login_helpers"
require "helpers/validation_helpers"
require "helpers/logger_helpers"
require "helpers/unique_content_helpers"

class RfhSchoolSelectionMethods < RfhBasePage
  include LoginHelpers
  include ValidationHelpers
  include LoggerHelpers
  include UniqueContentHelpers

  def set_org_type(org_type)
    # Confirm we are on org selection
    expect(page).to have_current_path(%r{/procurement-support/organisation_type}, url: true, wait: 10)
    expect(rfh_what_type_of_org_comps.text_page_heading.text).to include("What type of organisation are you buying for?")

    # Select org based on scenario choice
    case org_type
    when "Single School"
      rfh_what_type_of_org_comps.radio_a_single_school.click
    when "Multi School"
      rfh_what_type_of_org_comps.radio_an_academy_trust_or_federation.click
    else
      log.error "Your step has the incorrect org type defined. Please set 'Single School' or 'Multi-School'"
    end

    # Continue on to the relevant org selection screen
    rfh_what_type_of_org_comps.button_continue.click
  end

  def process_data_for_school_selection(org_type)
    case org_type
    when "Single School"
      single_school_org_selection
      verify_school_details_cya_single_school
    when "Multi School"
      multi_school_org_selection
      verify_school_details_cya_multi_school
      complete_selection_of_school_in_your_trust
    else
      log.error "Your step has the incorrect org type defined. Please set 'Single School' or 'Multi-School'"
    end

    # Shared flow screens
    complete_name_screen
    complete_email_address_screen
  end

  def single_school_org_selection
    # Confirm we are on the "Search for your school" screen
    expect(page).to have_current_path(%r{/procurement-support/search_for_organisation}, url: true, wait: 10)
    expect(rfh_search_for_your_school_comps.text_page_heading.text).to include("Search for your school")

    # Search for Hazelwick School
    # There are sometimes issues with this loading the school correctly, the below is a complete retry attempt before we fail the test.
    case_org_name = "Hazelwick School"
    rfh_state.org_name = "Hazelwick School"

    begin
      rfh_search_for_your_school_comps.input_organisation_name.send_keys(case_org_name)
      sleep(2) # allow time for the dropdown list to populate / render with correct content
      rfh_search_for_your_school_comps.dropdown_select_org_based_on_ukprn("137263").click
    rescue StandardError
      begin
        rfh_search_for_your_school_comps.input_organisation_name.clear
        rfh_search_for_your_school_comps.input_organisation_name.set("")
        rfh_search_for_your_school_comps.input_organisation_name.send_keys(case_org_name)
        sleep(2) # allow time for the dropdown list to populate / render with correct content
        rfh_search_for_your_school_comps.dropdown_select_org_based_on_ukprn("137263").click
      rescue StandardError
        raise "Both attempts failed"
      end
    end

    # Store our info so far in the rfh_state dto to be validated against as we move through the app.
    rfh_state.name_and_address = "Hazelwick School Close, Three Bridges, Crawley, West Sussex, RH10 1SX"
    rfh_state.local_authority = "West Sussex"
    rfh_state.head_teacher = "Mr David Leadbitter"
    rfh_state.phase_of_education = "Secondary"
    rfh_state.school_type_1 = "Academy converter"
    rfh_state.school_type_2 = "Single" # Not sure why but the same reference is used on 2 screens with different meaning.
    rfh_state.ids_urn = "137263"
    rfh_state.ids_dfe_num = "4029"
    rfh_state.ids_ukprn = "10034642"

    # Continue on to the "Is this the school you're buying for?" CYA page
    rfh_search_for_your_school_comps.button_continue.click
  end

  def multi_school_org_selection
    # Confirm we are on the "Search for an academy trust or federation" screen
    expect(page).to have_current_path(%r{/procurement-support/search_for_organisation}, url: true, wait: 10)
    expect(rfh_search_for_an_academy_trust_comps.text_page_heading.text).to include("Search for an academy trust or federation")

    # Search for Hazelwick School
    # There are sometimes issues with this loading the school correctly, the below is a complete retry attempt before we fail the test.
    case_group_name = "E-ACT"
    rfh_state.group_name = "E-ACT"

    begin
      rfh_search_for_an_academy_trust_comps.input_organisation_name.send_keys(case_group_name)
      sleep(2) # allow time for the dropdown list to populate / render with correct content
      rfh_search_for_an_academy_trust_comps.dropdown_select_org_based_on_ukprn("10058234").click
    rescue StandardError
      begin
        rfh_search_for_an_academy_trust_comps.input_organisation_name.clear
        rfh_search_for_an_academy_trust_comps.input_organisation_name.set("")
        rfh_search_for_an_academy_trust_comps.input_organisation_name.send_keys(case_group_name)
        sleep(2) # allow time for the dropdown list to populate / render with correct content
        rfh_search_for_an_academy_trust_comps.dropdown_select_org_based_on_ukprn("10058234").click
      rescue StandardError
        raise "Both attempts failed"
      end
    end

    # Store our info so far in the rfh_state dto to be validated against as we move through the app.
    rfh_state.name_and_address = "The Orangery, 28 Headlands, Kettering, NN15 7HP"
    rfh_state.group_type = "Multi-academy Trust"
    rfh_state.ids_ukprn = "10058234"
    rfh_state.ids_uid = "2974"

    # Continue on to the "Is this the school you're buying for?" CYA page
    rfh_search_for_an_academy_trust_comps.button_continue.click
  end

  def verify_school_details_cya_single_school
    # Confirm we are on the "Is this the school you're buying for?" screen
    expect(page).to have_current_path(%r{/procurement-support/confirm_organisation}, url: true, wait: 10)
    expect(rfh_is_this_the_school_your_buying_for_comps.text_page_heading.text).to include("Is this the school you're buying for?")

    # Retrieve and validate each of the info blobs about the school
    validate_value_contains(rfh_state.org_name, rfh_is_this_the_school_your_buying_for_comps.text_name_and_address.text)
    validate_value_contains(rfh_state.name_and_address, rfh_is_this_the_school_your_buying_for_comps.text_name_and_address.text)
    validate_value_contains(rfh_state.local_authority, rfh_is_this_the_school_your_buying_for_comps.text_local_authority.text)
    validate_value_contains(rfh_state.head_teacher, rfh_is_this_the_school_your_buying_for_comps.text_headteacher_or_principal.text)
    validate_value_contains(rfh_state.phase_of_education, rfh_is_this_the_school_your_buying_for_comps.text_phase_of_education.text)
    validate_value_contains(rfh_state.school_type_1, rfh_is_this_the_school_your_buying_for_comps.text_school_type.text)
    validate_value_contains(rfh_state.ids_urn, rfh_is_this_the_school_your_buying_for_comps.text_ids.text)
    validate_value_contains(rfh_state.ids_dfe_num, rfh_is_this_the_school_your_buying_for_comps.text_ids.text)
    validate_value_contains(rfh_state.ids_ukprn, rfh_is_this_the_school_your_buying_for_comps.text_ids.text)

    # Confirm these are correct and progress to the next screen
    rfh_is_this_the_school_your_buying_for_comps.radio_yes.click
    rfh_is_this_the_school_your_buying_for_comps.button_continue.click
  end

  def verify_school_details_cya_multi_school
    # Confirm we are on the "Is this the academy trust or federation you're buying for?" screen
    expect(page).to have_current_path(%r{/procurement-support/confirm_organisation}, url: true, wait: 10)
    expect(rfh_if_this_the_academy_trust_your_buying_for_comps.text_page_heading.text).to include("Is this the academy trust or federation you're buying for?")

    # Retrieve and validate each of the info blobs about the school
    validate_value_contains(rfh_state.group_name, rfh_if_this_the_academy_trust_your_buying_for_comps.text_group_name.text)
    validate_value_contains(rfh_state.name_and_address, rfh_if_this_the_academy_trust_your_buying_for_comps.text_address.text)
    validate_value_contains(rfh_state.group_type, rfh_if_this_the_academy_trust_your_buying_for_comps.text_group_type.text)
    validate_value_contains(rfh_state.ids_ukprn, rfh_if_this_the_academy_trust_your_buying_for_comps.text_ids.text)
    validate_value_contains(rfh_state.ids_uid, rfh_if_this_the_academy_trust_your_buying_for_comps.text_ids.text)

    # Confirm these are correct and progress to the next screen
    rfh_if_this_the_academy_trust_your_buying_for_comps.radio_yes.click
    rfh_if_this_the_academy_trust_your_buying_for_comps.button_continue.click
  end

  def complete_name_screen
    # Confirm we are on the "What is your name?" screen
    expect(page).to have_current_path(%r{/procurement-support/name}, url: true, wait: 10)
    expect(rfh_what_is_your_name_comps.text_page_heading.text).to include("What is your name?")

    # Enter in a name associated with this auto test
    random_num_for_name = generate_random_number(9, preserve_leading_zeros: true)
    first_name = "Auto-Test-Fn-#{random_num_for_name}"
    last_name = "Auto-Test-Ln-#{random_num_for_name}"
    rfh_what_is_your_name_comps.input_first_name.set(first_name)
    rfh_what_is_your_name_comps.input_last_name.set(last_name)

    # Store our info so far in the rfh_state dto to be validated against as we move through the app
    rfh_state.your_name = "#{first_name} #{last_name}"

    # Move on to the email screen
    rfh_what_is_your_name_comps.button_continue.click
  end

  def complete_email_address_screen
    # Confirm we are on the "What is your name?" screen
    expect(page).to have_current_path(%r{/procurement-support/email}, url: true, wait: 10)
    expect(rfh_what_is_your_email_comps.text_page_heading.text).to include("What is your email address?")

    # Enter the email address
    email_address = SECRETS["test_user_5"]
    rfh_what_is_your_email_comps.input_email.set(email_address)

    # Store our info so far in the rfh_state dto to be validated against as we move through the app
    rfh_state.your_email_address = email_address

    # Move on to the next screen
    rfh_what_is_your_email_comps.button_continue.click
  end

  def complete_selection_of_school_in_your_trust
    # Confirm we are on the "Which schools in your academy trust or federation will be involved in this procurement?" screen
    expect(page).to have_current_path(%r{/procurement-support/school_picker}, url: true, wait: 10)
    expect(rfh_which_school_in_your_academy_comps.text_page_heading.text).to include("Which schools in your academy trust or federation will be involved in this procurement?")

    # Pick a school from the list.
    rfh_which_school_in_your_academy_comps.text_first_school_from_the_list.click

    # Move on to the next screen
    rfh_which_school_in_your_academy_comps.button_continue.click

    # Confirm we are on the "Are these the schools you're buying for?" screen
    expect(page).to have_current_path(%r{/procurement-support/confirm_schools}, url: true, wait: 10)
    expect(rfh_are_these_the_schools_your_buying_for_comps.text_page_heading.text).to include("Are these the schools you're buying for?")

    # Store our info so far in the rfh_state dto to be validated against as we move through the app
    rfh_state.school_name = rfh_are_these_the_schools_your_buying_for_comps.text_school_name
    rfh_state.name_and_address = rfh_are_these_the_schools_your_buying_for_comps.text_address
    rfh_state.phase_of_education = rfh_are_these_the_schools_your_buying_for_comps.text_phase_of_education
    rfh_state.local_authority = rfh_are_these_the_schools_your_buying_for_comps.text_local_authority

    # Confirm these are the details by selecting yes
    rfh_are_these_the_schools_your_buying_for_comps.radio_yes.click

    # Move on to the next screen
    rfh_are_these_the_schools_your_buying_for_comps.button_continue.click
  end
end
