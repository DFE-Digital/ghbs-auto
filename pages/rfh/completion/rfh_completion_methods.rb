# frozen_string_literal: true

require "pages/shared/shared_global_methods"
require "pages/rfh/rfh_base_page"
require "components/rfh/completion/rfh_access_needs_comps"
require "components/rfh/completion/rfh_how_did_you_find_us_comps"
require "components/rfh/completion/rfh_send_your_request_comps"
require "helpers/login_helpers"
require "helpers/validation_helpers"
require "helpers/logger_helpers"

class RfhCompletionMethods < RfhBasePage
  include LoginHelpers
  include ValidationHelpers
  include LoggerHelpers

  def complete_access_needs_screen
    # Confirm we are on the "Do you have any access needs that we need to be aware of when we contact you?" screen
    expect(page).to have_current_path(%r{/procurement-support/special_requirements}, url: true, wait: 10)
    expect(rfh_access_needs_comps.text_page_heading.text).to include("Do you have any access needs that we need to be aware of when we contact you?")

    # Select the "Yes" option and populate the reason why
    rfh_access_needs_comps.radio_yes.click
    access_info = "Access needs: This is an auto test at #{Time.now}"
    rfh_access_needs_comps.input_tell_us.set(access_info)

    # Store our info so far in the rfh_state dto to be validated against as we move through the app
    rfh_state.origin = access_info

    # Move on to the next screen
    rfh_how_can_we_help_comps.button_continue.click
  end

  def complete_how_did_you_find_screen
    # Confirm we are on the "How did you first find out about this service?" screen
    expect(page).to have_current_path(%r{/procurement-support/origin}, url: true, wait: 10)
    expect(rfh_how_did_you_find_us_comps.text_page_heading.text).to include("How did you first find out about this service?")

    # Select the "Yes" option and populate the reason why
    rfh_how_did_you_find_us_comps.radio_other.click
    how_find_us_info = "How find: This is an auto test at #{Time.now}"
    rfh_how_did_you_find_us_comps.button_other_specify.set(how_find_us_info)

    # Store our info so far in the rfh_state dto to be validated against as we move through the app
    rfh_state.origin = how_find_us_info

    # Move on to the next screen
    rfh_how_did_you_find_us_comps.button_continue.click
  end

  def complete_and_validate_send_your_request_screen
    # Confirm we are on the "Send your request" screen
    expect(page).to have_current_path(%r{/procurement-support/}, url: true, wait: 10)
    expect(rfh_send_your_request_comps.text_page_heading.text).to include("Send your request")

    # Validate all of the info from the previous screens
    validate_value_contains(rfh_state.your_name, rfh_send_your_request_comps.text_your_name.text)
    validate_value_contains(rfh_state.your_email_address, rfh_send_your_request_comps.text_your_email_address.text)
    validate_value_contains(rfh_state.org_name, rfh_send_your_request_comps.text_your_school.text)
    validate_value_contains(rfh_state.school_type_2, rfh_send_your_request_comps.text_school_type.text)
    validate_value_contains(rfh_state.type_of_goods_or_service, rfh_send_your_request_comps.text_type_of_goods_or_service.text)
    validate_value_contains(rfh_state.procurement_ammount, rfh_send_your_request_comps.text_procurement_amount.text)
    validate_value_contains(rfh_state.description_of_request, rfh_send_your_request_comps.text_description_of_request.text)
    validate_value_contains(rfh_state.accessibility, rfh_send_your_request_comps.text_accessibility.text)
    validate_value_contains(rfh_state.origin, rfh_send_your_request_comps.text_origin.text)
  end
end
