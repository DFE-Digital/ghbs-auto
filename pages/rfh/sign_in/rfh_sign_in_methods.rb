# frozen_string_literal: true

require "pages/shared/shared_global_methods"
require "pages/fabs/fabs_base_page"
require "pages/rfh/rfh_base_page"
require "components/fabs/fabs_home_comps"
require "components/rfh/sign_in/rfh_start_comps"
require "components/rfh/sign_in/rfh_do_you_have_a_dfe_signin_account_comps"
require "components/rfh/school_selection/rfh_what_type_of_org_comps"
require "pages/cms/cms_signin_flow_methods"
require "helpers/login_helpers"
require "helpers/validation_helpers"
require "helpers/logger_helpers"

class RfhSignInMethods < RfhBasePage
  include LoginHelpers
  include ValidationHelpers
  include LoggerHelpers

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
      rfh_do_you_have_a_dfe_signin_account_comps.radio_yes_use_dfe_sign_in.click
      expect(page).to have_current_path(%r{/signin/username}, url: true, wait: 10)
    end
  end
end
