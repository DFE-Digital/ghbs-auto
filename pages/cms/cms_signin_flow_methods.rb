# frozen_string_literal: true

require "pages/shared_global_methods"
require "pages/cms/cms_base_page"
require "components/cms/cms_login_page_comps"
require "components/dfe_signin/dfe_signin_access_the_service_page_comps"
require "components/dfe_signin/dfe_signin_enter_your_password_page_comps"

class CmsSignInFlowMethods < CmsBasePage
  def open_cms_cec_homepage
    visit SECRETS["dev_cec_cms_homepage_url"]
  end

  def validate_cms_homepage_loaded
    expect(page).to have_current_path(%r{/sign-in#my-cases}, url: true, wait: 10)
    expect(cms_login_page_comps.text_page_heading.text).to include("Case management system")
  end

  def continue_and_complete_dfe_signin
    cms_login_page_comps.button_signin.click

    # Navigates user through the DfE sign-in flow to the "My Cases" page
    shared_global_methods.complete_dfe_signin_as("MAT")

    # Complete the login process > my cases
    expect(page).to have_current_path(%r{/cec#my-cases}, url: true, wait: 10)
    expect(dfe_signin_enter_your_password_page_comps.text_page_heading.text).to include("My cases")

    puts "[INFO] Successfully signed in as MAT user"
  end
end
