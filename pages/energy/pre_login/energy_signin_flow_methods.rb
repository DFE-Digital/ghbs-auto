# frozen_string_literal: true

require "pages/shared/shared_global_methods"
require "pages/energy/energy_base_page"
require "components/energy/pre_login/energy_start_comps"
require "components/energy/pre_login/energy_before_you_start_comps"
require "components/energy/journey_start/energy_which_school_buying_for_comps"
require "pages/cms/cms_signin_flow_methods"
require "helpers/login_helpers"

class EnergySignInFlowMethods < EnergyBasePage
  include LoginHelpers

  def continue_to_before_you_start_page
    # Navigates user from the "start" page to the "before you start" page
    energy_start_comps.button_start_now.click
    expect(page).to have_current_path(%r{/before-you-start}, url: true, wait: 10)
    expect(energy_before_you_start_comps.text_page_heading.text).to include("Energy for Schools")
    expect(energy_before_you_start_comps.text_page_sub_heading.text).to include("Before you start")
  end

  def continue_to_access_dfe_signin_page
    # Navigates user from the "Before you start" page to the "DfE Signin page" page
    energy_before_you_start_comps.button_continue.click
    expect(page).to have_current_path(%r{/signin/username}, url: true, wait: 10)
    expect(dfe_signin_access_the_service_page_comps.text_page_heading.text).to include("Access the DfE Sign-in service")
  end

  def continue_complete_dfe_signin_flow_v1(user)
    # TODO: if the v2 approach is working and has increased stability, this is to be removed in a few weeks time from 19/03/26
    # Navigates user through the DfE sign-in flow to the "Which school are you buying for?" page
    world.shared_global_methods.complete_dfe_signin_as(user, "dev")

    # Complete the login process
    expect(page).to have_current_path(%r{/which-school-buying-for}, url: true, wait: 10)
    expect(energy_which_school_buying_for_comps.text_page_heading.text).to include("Which school or trust are you buying for?")

    puts "[INFO] Successfully signed in as #{user.capitalize} user"
  end

  def continue_complete_dfe_signin_flow_v2(user, environment, role = nil)
    # Set current_case_state
    current_user_state.user = user
    current_user_state.role = role
    current_user_state.env = environment
    current_user_state.base_url = "support" # this is overwritten based on login type

    # Retrieve the current url in case we need to retry login
    return_url = page.current_url

    defensive_login_retry(max_attempts: 3, sleep_s: 10, reset_between: false) do |attempt|
      restore_start_state(attempt: attempt, return_url: return_url)

      # Navigates user through the DfE sign-in flow to the "Which school are you buying for?" page
      world.shared_global_methods.complete_dfe_signin_as(user, "dev")

      # Complete the login process
      expect(page).to have_current_path(%r{/which-school-buying-for}, url: true, wait: 10)
      expect(energy_which_school_buying_for_comps.text_page_heading.text).to include("Which school or trust are you buying for?")

      puts "[INFO] Successfully signed in as #{user.capitalize} user"
    end
  end
end
