# frozen_string_literal: true

require "pages/shared/shared_global_methods"
require "pages/energy/energy_base_page"
require "components/energy/pre_login/energy_start_comps"
require "components/energy/pre_login/energy_before_you_start_comps"
require "components/energy/journey_start/energy_which_school_buying_for_comps"

class EnergySignInFlowMethods < EnergyBasePage
  def continue_to_before_you_start_page
    # Navigates user from the "start" page to the "before you start" page
    energy_start_comps.button_start_now.click
    expect(page).to have_current_path(%r{/before-you-start}, url: true, wait: 10)
    expect(energy_before_you_start_comps.text_page_heading.text).to include("Before you start")
  end

  def continue_to_access_dfe_signin_page
    # Navigates user from the "Before you start" page to the "DfE Signin page" page
    energy_before_you_start_comps.button_continue.click
    expect(page).to have_current_path(%r{/signin/username}, url: true, wait: 10)
    expect(dfe_signin_access_the_service_page_comps.text_page_heading.text).to include("Access the DfE Sign-in service")
  end

  def continue_complete_dfe_signin_flow(user)
    # Navigates user through the DfE sign-in flow to the "Which school are you buying for?" page
    world.shared_global_methods.complete_dfe_signin_as(user)

    # Complete the login process
    expect(page).to have_current_path(%r{/which-school-buying-for}, url: true, wait: 10)
    expect(energy_which_school_buying_for_comps.text_page_heading.text).to include("Which school are you buying for?")

    puts "[INFO] Successfully signed in as #{user.capitalize} user"
  end
end
