# frozen_string_literal: true

require "pages/cms/cms_base_page"
require "components/cms/create_a_case/cms_create_a_new_case_comps"
require "components/cms/create_a_case/cms_create_a_new_case_check_answers_comps"
require "components/cms/cms_mycases_page_comps"
require "helpers/unique_content_helpers"

class CmsCreateANewCaseMethods < CmsBasePage
  include UniqueContentHelpers

  def create_a_new_case_with_unique_data
    complete_create_a_new_case_page
    complete_and_validate_check_your_answers_page
  end

  def complete_create_a_new_case_page
    cms_mycases_page_comps.button_create_a_new_case.click
    expect(page).to have_current_path(%r{/support/case_requests/}, url: true, wait: 10)
    expect(cms_create_a_new_case_comps.text_page_heading.text).to include("Create a new case")

    case_org_name = "Hazelwick School"
    case_first_name = "AutoTestFN-#{Time.now.strftime('%S-%M-%H-%m-%d-%Y')}"
    case_last_name = "AutoTestLN"
    case_email = SECRETS["test_user_2"]
    case_phone = generate_random_number(11, preserve_leading_zeros: true)
    case_extension_phone = generate_random_number(11, preserve_leading_zeros: true)
    case_origin = "AutoTestOrigin-#{Time.now.strftime('%S-%M-%H-%m-%d-%Y')}"
    case_description_of_query = "I am an auto test living my best autotesty life, on this date time #{Time.now.strftime('%S-%M-%H-%m-%d-%Y')}"
    case_proc_value = generate_random_number_in_range(50_000, 999_999, preserve_leading_zeros: false)

    # Create a new case
    cms_create_a_new_case_comps.input_organisation_name.send_keys(case_org_name)
    sleep(1) # allow time for the dropdown list to populate / render with correct content
    cms_create_a_new_case_comps.dropdown_select_org_based_on_ukprn("10034642").click

    cms_create_a_new_case_comps.input_contact_first_name.set(case_first_name)
    cms_create_a_new_case_comps.input_contact_last_name.set(case_last_name)
    cms_create_a_new_case_comps.input_contact_email.set(case_email)
    cms_create_a_new_case_comps.input_contact_phone_number.set(case_phone)
    cms_create_a_new_case_comps.input_contact_extension_number.set(case_extension_phone)

    # Case origin
    cms_create_a_new_case_comps.radio_case_origin_other.click
    cms_create_a_new_case_comps.input_case_origin_other.set(case_origin)

    # Request type
    cms_create_a_new_case_comps.radio_request_type_procurement.click
    cms_create_a_new_case_comps.dropdown_request_type_procurement.click

    # Description of query
    cms_create_a_new_case_comps.input_description_of_query.set(case_description_of_query)

    # Procurement value
    cms_create_a_new_case_comps.input_procurement_value.set(case_proc_value)

    # Case source
    cms_create_a_new_case_comps.dropdown_case_source.click

    # Complete page
    cms_create_a_new_case_comps.button_save_and_continue.click

    # Validate page move
    expect(page).to have_current_path(%r{/support/case_requests/}, url: true, wait: 10)
    expect(cms_create_a_new_case_check_answers_comps.text_page_heading.text).to include("Check your answers before creating a new case")
  end

  def complete_and_validate_check_your_answers_page
    # Validate Organisation details
    # Contact details
    # Case origin
    # Case source
    # Request type
    # Description of query
    # Case details
  end
end
