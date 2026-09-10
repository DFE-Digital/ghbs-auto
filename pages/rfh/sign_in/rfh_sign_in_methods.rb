# frozen_string_literal: true

require "pages/shared/shared_global_methods"
require "pages/fabs/fabs_base_page"
require "pages/rfh/rfh_base_page"
require "components/fabs/fabs_home_comps"
require "components/rfh/sign_in/rfh_start_comps"
require "components/rfh/sign_in/rfh_do_you_have_a_dfe_signin_account_comps"
require "components/rfh/school_selection/rfh_what_type_of_org_comps"
require "components/rfh/sign_in/rfh_is_this_your_contact_info_comps"
require "components/dfe_signin/dfe_signin_access_the_service_page_comps"
require "pages/shared/shared_global_methods"
require "pages/cms/cms_signin_flow_methods"
require "helpers/login_helpers"
require "helpers/validation_helpers"
require "helpers/logger_helpers"
require "helpers/content_format_helpers"

class RfhSignInMethods < RfhBasePage
  include LoginHelpers
  include ValidationHelpers
  include LoggerHelpers
  include ContentFormatHelpers

  def nav_to_rfh_start_page
    fabs_home_comps.button_get_expert_buying_help.click
    expect(page).to have_current_path(%r{/procurement-support}, url: true, wait: 10)
    expect(rfh_start_comps.text_page_heading.text).to include("Request help and support for your procurement")
  end

  def start_the_rfh_flow
    rfh_start_comps.button_start_now.click
    expect(page).to have_current_path(%r{/procurement-support/sign_in}, url: true, wait: 10)
    expect(rfh_do_you_have_a_dfe_signin_account_comps.text_page_heading.text).to include("Do you have a DfE Sign-in account linked to the school that your request is about?")
  end

  def complete_login_as_x_user(user_type)
    if user_type == "unverified"
      rfh_do_you_have_a_dfe_signin_account_comps.radio_no_dont_use_dfe_sign_in.click
      rfh_do_you_have_a_dfe_signin_account_comps.button_continue.click
      expect(page).to have_current_path(%r{/procurement-support/organisation_type}, url: true, wait: 10)
      expect(rfh_what_type_of_org_comps.text_page_heading.text).to include("What type of organisation are you buying for?")
    else
      # Verified flow
      rfh_do_you_have_a_dfe_signin_account_comps.radio_yes_use_dfe_sign_in.click
      rfh_do_you_have_a_dfe_signin_account_comps.button_continue.click

      # Sign in to RFH
      complete_dfe_signin
    end

    rfh_state.signed_in_state = user_type
  end

  def complete_dfe_signin
    # Confirm were on the DfE Sign-in page
    expect(page).to have_current_path(%r{/signin/username}, url: true, wait: 10)
    expect(dfe_signin_access_the_service_page_comps.text_page_heading.text).to include("Access the DfE Sign-in service")

    # Complete signin as a SAT
    world.shared_global_methods.complete_dfe_signin_as("sat", "dev")

    # Confirm were on the "Is this your contact information?" page
    expect(page).to have_current_path(%r{/procurement-support/confirm_sign_in}, url: true, wait: 10)
    expect(rfh_is_this_your_contact_info_comps.text_page_heading.text).to include("Is this your contact information?")
  end

  def validate_logged_in_user_details(user_type)
    if user_type == "Single Academy Trust"
      # Confirm were on the "Is this your contact information?" page
      expect(page).to have_current_path(%r{/procurement-support/confirm_sign_in}, url: true, wait: 10)
      expect(rfh_is_this_your_contact_info_comps.text_page_heading.text).to include("Is this your contact information?")

      # Validate the contact info for the SAT user.
      expect(rfh_is_this_your_contact_info_comps.text_your_name.text).to include(email_to_display_name(case_state.user_email))
      expect(rfh_is_this_your_contact_info_comps.text_your_email_address.text).to include(case_state.user_email)

      # move on to the next page
      rfh_is_this_your_contact_info_comps.button_yes_continue.click
    else
      # TODO: logged in mat journey
    end

  end
end
