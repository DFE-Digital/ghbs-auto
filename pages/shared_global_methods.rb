# frozen_string_literal: true

require_relative "fabs/fabs_base_page"
require "components/dfe_signin/dfe_signin_access_the_service_page_comps"
require "components/dfe_signin/dfe_signin_enter_your_password_page_comps"

class SharedGlobalMethods < FabsBasePage
  def set_axe_enabled(axe_status)
    ENV["AXE"] = axe_status ? "true" : "false"
  end

  def complete_dfe_signin_as(user)
    user = user.to_s.downcase
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

    # this method assumes we are already on the first of the DfE Sign-In flow page
    dfe_signin_access_the_service_page_comps.input_username.set(credentials[:email])

    # Move to the stand-alone password screen
    dfe_signin_access_the_service_page_comps.button_sign_in.click
    expect(page).to have_current_path(%r{/signin/password}, url: true, wait: 10)
    expect(dfe_signin_enter_your_password_page_comps.text_page_heading.text).to include("Enter your password")

    # Complete the login process
    dfe_signin_enter_your_password_page_comps.input_password.set(credentials[:password])
    dfe_signin_enter_your_password_page_comps.button_next.click
    expect(page).to have_current_path(%r{/which-school-buying-for}, url: true, wait: 10)
    expect(dfe_signin_enter_your_password_page_comps.text_page_heading.text).to include("Which school are you buying for?")

    puts "[INFO] Successfully signed in as #{user.capitalize} user"
  end

end
