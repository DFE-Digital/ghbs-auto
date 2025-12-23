# frozen_string_literal: true

require "pages/cms/cms_base_page"
require "components/cms/create_a_case/cms_create_a_new_case_comps"
require "components/cms/create_a_case/cms_create_a_new_case_check_answers_comps"
require "components/cms/case/cms_single_case_view_page_comps"
require "components/cms/case/cms_single_case_nav_comps"
require "components/cms/case/cms_single_case_case_details_comps"
require "components/cms/case/cms_single_case_case_details_case_summary_comps"
require "components/cms/case/cms_single_case_case_details_case_summary_check_answers_comps"
require "components/cms/cms_mycases_page_comps"
require "helpers/unique_content_helpers"
require "helpers/validation_helpers"
require "helpers/content_format_helpers"

class CmsCreateANewCaseMethods < CmsBasePage
  include UniqueContentHelpers
  include ValidationHelpers
  include ContentFormatHelpers

  def create_a_new_case_with_unique_data
    complete_create_a_new_case_page
    complete_and_validate_check_your_answers_page
  end

  def complete_create_a_new_case_page
    cms_mycases_page_comps.button_create_a_new_case.click
    expect(page).to have_current_path(%r{/support/case_requests/}, url: true, wait: 10)
    expect(cms_create_a_new_case_comps.text_page_heading.text).to include("Create a new case")

    # Create a new case
    ### Organisation name
    case_org_name = "Hazelwick School"
    case_state.case_organisation_name = case_org_name
    cms_create_a_new_case_comps.input_organisation_name.send_keys(case_org_name)
    sleep(1) # allow time for the dropdown list to populate / render with correct content
    cms_create_a_new_case_comps.dropdown_select_org_based_on_ukprn("10034642").click

    ### Contact first name
    case_first_name = "AutoTestFN-#{Time.now.strftime('%S-%M-%H-%m-%d-%Y')}"
    case_state.case_contact_first_name = case_first_name
    cms_create_a_new_case_comps.input_contact_first_name.set(case_first_name)

    ### Contact last name
    case_last_name = "AutoTestLN"
    case_state.case_contact_last_name = case_last_name
    cms_create_a_new_case_comps.input_contact_last_name.set(case_last_name)

    ### Contact email
    case_email = SECRETS["test_user_2"]
    case_state.case_contact_email = case_email
    cms_create_a_new_case_comps.input_contact_email.set(case_email)

    ### Contact phone number (optional)
    case_phone = "07#{generate_random_number(9, preserve_leading_zeros: true)}"
    case_state.case_contact_phone_number = case_phone
    cms_create_a_new_case_comps.input_contact_phone_number.set(case_phone)

    ### Contact extension number (optional)
    case_extension_phone = "07#{generate_random_number(9, preserve_leading_zeros: true)}"
    case_state.case_contact_extension_number = case_extension_phone
    cms_create_a_new_case_comps.input_contact_extension_number.set(case_extension_phone)

    # Case origin
    case_origin = "AutoTestOrigin-#{Time.now.strftime('%S-%M-%H-%m-%d-%Y')}"
    case_state.case_case_origin = "Other - #{case_origin}"
    cms_create_a_new_case_comps.radio_case_origin_other.click
    cms_create_a_new_case_comps.input_case_origin_other.set(case_origin)

    # Request type
    cms_create_a_new_case_comps.radio_request_type_procurement.click
    case_state.case_request_type = "Procurement"
    case_request_type_sub_cat = "Books"
    case_state.case_procurement_sub_category = case_request_type_sub_cat
    cms_create_a_new_case_comps.dropdown_request_type_procurement(case_request_type_sub_cat).click

    # Description of query
    case_description_of_query = "I am an auto test living my best autotesty life, on this date time #{Time.now.strftime('%S-%M-%H-%m-%d-%Y')}"
    case_state.case_description_of_query = case_description_of_query
    cms_create_a_new_case_comps.input_description_of_query.set(case_description_of_query)

    # Procurement value
    case_proc_value = generate_random_number_in_range(50_000, 999_999, preserve_leading_zeros: false)
    case_state.case_procurement_value = format_currency(case_proc_value)
    cms_create_a_new_case_comps.input_procurement_value.set(case_proc_value)

    # Case source
    case_source_option = "Schools Commercial Team (SCT)"
    case_state.case_case_source = case_source_option
    cms_create_a_new_case_comps.dropdown_case_source(case_source_option).click

    # Complete page
    cms_create_a_new_case_comps.button_save_and_continue.click

    # Validate page move
    expect(page).to have_current_path(%r{/support/case_requests}, url: true, wait: 10)
    expect(cms_create_a_new_case_check_answers_comps.text_page_heading.text).to include("Check your answers before creating a new case")
  end

  def complete_and_validate_check_your_answers_page
    # Validate Organisation details
    validate_values_match(case_state.case_organisation_name.upcase, cms_create_a_new_case_check_answers_comps.text_organisation_name.text.upcase)
    # TODO: These 3 below, will be checked by directly calling the db to validate the data. However at this point in time the auto pack lacks this access.
    # Organisation postcode
    # Organisation URN
    # Organisation UKPRN

    # Contact details
    contact_full_name = "#{case_state.case_contact_first_name} #{case_state.case_contact_last_name}"
    validate_values_match(contact_full_name, cms_create_a_new_case_check_answers_comps.text_contact_name.text)

    validate_values_match(case_state.case_contact_email, cms_create_a_new_case_check_answers_comps.text_contact_email.text)
    validate_values_match(case_state.case_contact_phone_number, cms_create_a_new_case_check_answers_comps.text_contact_phone_number.text)
    validate_values_match(case_state.case_contact_extension_number, cms_create_a_new_case_check_answers_comps.text_contact_extension_number.text)

    # Case origin
    validate_values_match(case_state.case_case_origin, cms_create_a_new_case_check_answers_comps.text_origin.text)

    # Case source
    validate_values_match(case_state.case_case_source, cms_create_a_new_case_check_answers_comps.text_case_source.text)

    # Request type
    validate_values_match(case_state.case_request_type, cms_create_a_new_case_check_answers_comps.text_request_type.text)
    validate_values_match(case_state.case_procurement_sub_category, cms_create_a_new_case_check_answers_comps.text_procurement_sub_category.text)

    # Description of query
    validate_values_match(case_state.case_description_of_query, cms_create_a_new_case_check_answers_comps.text_summary.text)

    # Case details
    validate_values_match(case_state.case_procurement_value, cms_create_a_new_case_check_answers_comps.text_procurement_value.text)

    # Complete page
    cms_create_a_new_case_check_answers_comps.button_create_case.click

    # Validate page move
    expect(page).to have_current_path(%r{/support/cases}, url: true, wait: 10)
    expect(cms_single_case_view_page_comps.text_page_heading.text.upcase).to include(case_state.case_organisation_name.upcase)
  end

  def change_case_level_to(case_level)
    # Log the case number
    case_state.case_number = cms_single_case_view_page_comps.text_page_heading_case_number.text

    # Open Case Details tab and select to "Change" Case Summary
    cms_single_case_nav_comps.link_case_details.click
    expect(cms_single_case_case_details_comps.text_page_heading.text).to include("Case details")
    # wait_for_heading_includes(cms_single_case_case_details_comps.text_page_heading, "Case details", timeout: 5)
    cms_single_case_case_details_comps.link_change_case_summary.click
    expect(cms_single_case_case_details_case_summary_comps.text_page_heading.text).to include("Update case summary")

    # Set case to be level X

    case case_level.delete('"')
    when "1"
      cms_single_case_case_details_case_summary_comps.radio_case_level_1.click
    when "2"
      cms_single_case_case_details_case_summary_comps.radio_case_level_2.click
    when "3"
      cms_single_case_case_details_case_summary_comps.radio_case_level_3.click
    when "4"
      cms_single_case_case_details_case_summary_comps.radio_case_level_4.click
    when "5"
      cms_single_case_case_details_case_summary_comps.radio_case_level_5.click
    when "6"
      cms_single_case_case_details_case_summary_comps.radio_case_level_6.click
    else
      raise ArgumentError, "Case level '#{case_level}' hasn't been implemented yet."
    end

    cms_single_case_case_details_case_summary_comps.button_continue.click
    expect(cms_single_case_case_details_case_summary_check_answers_comps.text_page_heading.text).to include("Check your answers before updating case summary")

    case case_level.delete('"')
    when "1"
      expect(cms_single_case_case_details_case_summary_check_answers_comps.text_case_level.text).to include("1 - General guidance")
    when "2"
      expect(cms_single_case_case_details_case_summary_check_answers_comps.text_case_level.text).to include("2 - Specific advice")
    when "3"
      expect(cms_single_case_case_details_case_summary_check_answers_comps.text_case_level.text).to include("3 - Support with buying")
    when "4"
      expect(cms_single_case_case_details_case_summary_check_answers_comps.text_case_level.text).to include("4 - DfE buying through a framework")
    when "5"
      expect(cms_single_case_case_details_case_summary_check_answers_comps.text_case_level.text).to include("5 - DfE buying by getting quotes or bids")
    when "6"
      expect(cms_single_case_case_details_case_summary_check_answers_comps.text_case_level.text).to include("6 - DfE Energy for Schools support case")
    else
      raise ArgumentError, "Case level '#{case_level}' hasn't been implemented yet."
    end

    cms_single_case_case_details_case_summary_check_answers_comps.button_save.click
    expect(cms_single_case_case_details_comps.text_page_heading.text).to include("Case details")

    # Final validation that we have successfully created the level X case.
    expect(cms_single_case_case_details_comps.text_page_heading.text).to include("Case details")

    case case_level.delete('"')
    when "1"
      expect(cms_single_case_case_details_comps.text_case_summary_case_level.text).to include("1 - General guidance")
    when "2"
      expect(cms_single_case_case_details_comps.text_case_summary_case_level.text).to include("2 - Specific advice")
    when "3"
      expect(cms_single_case_case_details_comps.text_case_summary_case_level.text).to include("3 - Support with buying")
    when "4"
      expect(cms_single_case_case_details_comps.text_case_summary_case_level.text).to include("4 - DfE buying through a framework")
    when "5"
      expect(cms_single_case_case_details_comps.text_case_summary_case_level.text).to include("5 - DfE buying by getting quotes or bids")
    when "6"
      expect(cms_single_case_case_details_comps.text_case_summary_case_level.text).to include("6 - DfE Energy for Schools support case")
    else
      raise ArgumentError, "Case level '#{case_level}' hasn't been implemented yet."
    end

    puts("[INFO] Case has been successfully set to level #{case_level}")
  end
end
