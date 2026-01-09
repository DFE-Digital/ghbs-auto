# frozen_string_literal: true

require "pages/shared/shared_global_methods"
require "pages/cms/cms_base_page"
require "components/cms/cms_login_page_comps"
require "components/dfe_signin/dfe_signin_access_the_service_page_comps"
require "components/dfe_signin/dfe_signin_enter_your_password_page_comps"
require "components/energy/pre_login/energy_start_comps"
require "components/energy/pre_login/energy_before_you_start_comps"
require "components/energy/journey_start/energy_which_school_buying_for_comps"
require "helpers/validation_helpers"
require "components/cms/cms_mycases_page_comps"

class CmsSignInFlowMethods < CmsBasePage
  include ValidationHelpers
  def open_cms_cec_homepage
    visit SECRETS["dev_cec_cms_homepage_url"]
  end

  def open_cms_cec_find_a_case_screen
    visit SECRETS["dev_cec_cms_find_a_case_url"]
  end

  def open_cms_proc_ops_homepage
    visit SECRETS["dev_proc_ops_cms_homepage_url"]
  end

  def validate_cms_homepage_loaded
    expect(page).to have_current_path(%r{/sign-in#my-cases}, url: true, wait: 10)
    expect(cms_login_page_comps.text_page_heading.text).to include("Case management system")
  end

  def continue_and_complete_dfe_signin_as_cec_admin
    cms_login_page_comps.button_signin.click

    # Navigates user through the DfE sign-in flow to the "My Cases" page
    world.shared_global_methods.complete_dfe_signin_as("cec","dev")

    # Complete the login process > my cases
    expect(page).to have_current_path(%r{/cec#my-cases}, url: true, wait: 10)
    expect(dfe_signin_enter_your_password_page_comps.text_page_heading.text).to include("My cases")

    puts "[INFO] Successfully signed in as CEC Admin user"
  end

  def continue_and_complete_dfe_signin_as_proc_ops_admin
    cms_login_page_comps.button_signin.click
    # Navigates user through the DfE sign-in flow to the "My Cases" page
    world.shared_global_methods.complete_dfe_signin_as("proc ops","dev")

    # Complete the login process > my cases
    expect(page).to have_current_path(%r{/support#my-cases}, url: true, wait: 20)
    expect(cms_mycases_page_comps.text_page_heading.text).to include("My cases")

    puts "[INFO] Successfully signed in as Proc Ops Admin user"
  end

  def continue_as_signed_in_user_to_which_school
    # start to before you start page
    energy_start_comps.button_start_now.click
    expect(page).to have_current_path(%r{/before-you-start}, url: true, wait: 2)
    wait_for_heading_includes(energy_before_you_start_comps.text_page_heading, "Before you start", timeout: 2)

    # Move from before you start to school selection
    energy_before_you_start_comps.button_continue.click
    expect(page).to have_current_path(%r{/which-school-buying-for}, url: true, wait: 2)
    expect(energy_which_school_buying_for_comps.text_page_heading.text).to include("Which school are you buying for?")
  end
end
