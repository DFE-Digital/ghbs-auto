# frozen_string_literal: true

require "pages/shared_global_methods"
require "pages/energy/energy_base_page"
require "components/energy/energy_start_page_comps"
require "components/energy/energy_before_you_start_page_comps"
require "components/dfe_signin/dfe_signin_access_the_service_page_comps"
require "components/dfe_signin/dfe_signin_enter_your_password_page_comps"

class EnergySignInFlowMethods < EnergyBasePage

  def continue_to_before_you_start_page
    # Navigates user from the "start" page to the "before you start" page
    energy_start_page_comps.button_signin_now.click
    expect(page).to have_current_path(%r{/before-you-start}, url: true, wait: 10)
    expect(energy_before_you_start_page_comps.text_page_heading.text).to include("Energy for Schools")
  end

  def continue_to_access_dfe_signin_page
    # Navigates user from the "Before you start" page to the "DfE Signin page" page
    energy_before_you_start_page_comps.button_continue.click
    expect(page).to have_current_path(%r{/signin/username}, url: true, wait: 10)
    expect(dfe_signin_enter_your_password_page_comps.text_page_heading.text).to include("Access the DfE Sign-in service")
  end

  def continue_compelte_dfe_signin_flow(user)
    # Navigates user through the DfE sign-in flow to the "Which school are you buying for?" page
    complete_dfe_signin_as(user)
  end

  def complete_dfe_signin_as(user)
    user = user.downcase
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
    dfe_signin_access_the_service_page_comps.input_username.set(credentials[:email])

    # Move to the stand-alone password screen
    dfe_signin_enter_your_password_page_comps.button_next.click
    expect(page).to have_current_path(%r{/signin/password}, url: true, wait: 10)
    expect(dfe_signin_enter_your_password_page_comps.text_page_heading.text).to include("Enter your password")

    # Complete the login process
    dfe_signin_enter_your_password_page_comps.input_password.set(credentials[:password])
    dfe_signin_access_the_service_page_comps.button_sign_in.click
    expect(page).to have_current_path(%r{/which-school-buying-for}, url: true, wait: 10)
    expect(dfe_signin_enter_your_password_page_comps.text_page_heading.text).to include("Which school are you buying for?")

    puts "[INFO] Successfully signed in as #{user.capitalize} user"
  end

end
