# frozen_string_literal: true

require "pages/shared/shared_global_base_page"
require "components/dfe_signin/dfe_signin_access_the_service_page_comps"
require "components/dfe_signin/dfe_signin_enter_your_password_page_comps"
require "components/dfe_signin/dfe_signin_enter_code_comps"
require "components/dfe_signin/dfe_signin_verify_your_identity_comps"
require "components/dfe_signin/user_management/dfe_signin_1_manage_users_comps"
require "helpers/validation_helpers"

class SharedGlobalMethods < SharedGlobalMethodsBasePage
  include ValidationHelpers

  def set_axe_enabled(axe_status)
    ENV["AXE"] = axe_status ? "true" : "false"
  end

  def complete_dfe_signin_as(user, environment)
    user = user.downcase
    credentials = case user
                  when "mat"
                    { email: SECRETS["school_energy_mat_username"],
                      password: SECRETS["school_energy_mat_password"] }
                  when "sat"
                    { email: SECRETS["school_energy_sat_username"],
                      password: SECRETS["school_energy_sat_password"] }
                  when "proc ops"
                    { email: SECRETS["proc_ops_cms_username"],
                      password: SECRETS["proc_ops_cms_password"] }
                  when "cec"
                    { email: SECRETS["cec_cms_username"],
                      password: SECRETS["cec_cms_password"] }
                  else
                    raise ArgumentError, "Unknown user type: '#{user}'"
                  end

    # Add to case state
    case_state.user_email = credentials[:email]
    case_state.user_type = user

    # NOTE: this method assumes we are already on the first page of the DfE Sign-In flow
    expect(page).to have_current_path(%r{/signin/username}, url: true, wait: 10)
    dfe_signin_access_the_service_page_comps.input_username.set(credentials[:email])

    if environment == "dev"
      # This env uses the test signin server
      dfe_signin_access_the_service_page_comps.button_next.click
      wait_for_heading_includes(dfe_signin_enter_your_password_page_comps.text_page_heading_test_server, "Enter your password", timeout: 10)
      dfe_signin_enter_your_password_page_comps.input_password_test_server.set(credentials[:password])
      dfe_signin_enter_your_password_page_comps.button_sign_in_test_server.click
    end

    if environment == "stg"
      # This env uses the pp signin server
      # Move to the stand-alone password screen and complete
      dfe_signin_access_the_service_page_comps.button_next.click
      expect(page).to have_current_path(%r{/oauth2/v2.0}, url: true, wait: 10)
      wait_for_heading_includes(dfe_signin_enter_your_password_page_comps.text_page_heading, "Enter password", timeout: 10)
      dfe_signin_enter_your_password_page_comps.input_password.set(credentials[:password])
      dfe_signin_enter_your_password_page_comps.button_sign_in.click

      # Send the verification code to the email
      expect(page).to have_current_path(%r{/login}, url: true, wait: 10)
      wait_for_heading_includes(dfe_signin_verify_your_identity_comps.text_page_heading, "Verify your identity", timeout: 5)
      dfe_signin_verify_your_identity_comps.button_email_code_to.click

      # Use retrieved code to populate input

      # dfe_signin_enter_code_comps.input_enter_code.set("TBC-MFA-Code")
      wait_for_heading_includes(dfe_signin_enter_code_comps.text_page_heading, "Enter code", timeout: 5)

      # Temp stop gap to allow dev until new logic is implemented above
      sleep(10)

      # dfe_signin_enter_code_comps.button_verify.click
    end

    # puts "[INFO] Successfully signed in as #{user.capitalize} user"
  end

  def complete_dfe_signin_org_management_as(user)
    user = user.downcase
    credentials = case user
                  when "test_server_approver"
                    { email: SECRETS["test_server_approver_username"],
                      password: SECRETS["test_server_approver_password"] }
                  else
                    raise ArgumentError, "Unknown user type: '#{user}'"
                  end

    # Add to case state
    case_state.user_email = credentials[:email]
    case_state.user_type = user

    # NOTE: this method assumes we are already on the first page of the DfE Sign-In flow
    expect(page).to have_current_path(%r{/signin/username}, url: true, wait: 10)
    dfe_signin_access_the_service_page_comps.input_username.set(credentials[:email])
    dfe_signin_access_the_service_page_comps.button_next.click
    wait_for_heading_includes(dfe_signin_enter_your_password_page_comps.text_page_heading_test_server, "Enter your password", timeout: 10)
    dfe_signin_enter_your_password_page_comps.input_password_test_server.set(credentials[:password])
    dfe_signin_enter_your_password_page_comps.button_sign_in_test_server.click

    # Validate we have arrived in the correct Manage Users screen
    expect(page).to have_current_path(%r{/approvals/users}, url: true, wait: 10)
    wait_for_heading_includes(dfe_signin_1_manage_users_comps.text_page_heading, "Manage users", timeout: 5)
  end
end
