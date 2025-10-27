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
    expect(page).to have_current_path(%r{/signin/username}, url: true, wait: 10)
    expect(dfe_signin_access_the_service_page_comps_2.text_page_heading.text).to include("Access the DfE Sign-in service")

    user = "mat"
    credentials = case user
                  when "mat"
                    { email: SECRETS["school_energy_mat_username"],
                      password: SECRETS["school_energy_mat_password"] }
                  when "sat"
                    { email: SECRETS["school_energy_sat_username"],
                      password: SECRETS["school_energy_sat_password"] }
                  else
                    raise ArgumentError, "Unknown user type: '#{user}'"
                  end

    # this method assumes we are already on the first page of the DfE Sign-In flow
    expect(page).to have_current_path(%r{/signin/username}, url: true, wait: 10)
    dfe_signin_access_the_service_page_comps_2.input_username.set(credentials[:email])

    # Move to the stand-alone password screen
    dfe_signin_enter_your_password_page_comps_2.button_next.click
    expect(page).to have_current_path(%r{/signin/password}, url: true, wait: 10)
    expect(dfe_signin_enter_your_password_page_comps_2.text_page_heading.text).to include("Enter your password")

    # Complete the login process
    dfe_signin_enter_your_password_page_comps_2.input_password.set(credentials[:password])
    dfe_signin_access_the_service_page_comps_2.button_sign_in.click
    expect(page).to have_current_path(%r{/cec#my-cases}, url: true, wait: 10)
    expect(dfe_signin_enter_your_password_page_comps_2.text_page_heading.text).to include("My cases")

    puts "[INFO] Successfully signed in as #{user.capitalize} user"
  end

end
