# frozen_string_literal: true

require "pages/shared/shared_global_methods"
require "pages/cms/cms_base_page"
require "components/cms/cms_login_page_comps"
require "components/dfe_signin/dfe_signin_access_the_service_page_comps"
require "components/dfe_signin/dfe_signin_enter_your_password_page_comps"
require "components/energy/pre_login/energy_start_comps"
require "components/energy/pre_login/energy_before_you_start_comps"
require "components/energy/journey_start/energy_which_school_buying_for_comps"
require "components/cms/cms_top_nav_comps"
require "helpers/validation_helpers"
require "components/cms/cms_mycases_page_comps"

class CmsSigninFlowMethods < CmsBasePage
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
    expect(page).to have_current_path(%r{/cms/sign-in}, url: true, wait: 10)
    expect(cms_login_page_comps.text_page_heading.text).to include("Case management system")
  end

  def continue_and_complete_dfe_signin_as_cec_admin
    cms_login_page_comps.button_signin.click

    # Navigates user through the DfE sign-in flow to the "My Cases" page
    world.shared_global_methods.complete_dfe_signin_as("cec", "dev")

    # Complete the login process > my cases
    expect(page).to have_current_path(%r{/cec#my-cases}, url: true, wait: 10)
    expect(dfe_signin_enter_your_password_page_comps.text_page_heading.text).to include("My cases")

    puts "[INFO] Successfully signed in as CEC Admin user"
  end

  def continue_and_complete_dfe_signin_as_proc_ops_admin(user, environment)
    defensive_login_retry(max_attempts: 3, sleep_s: 10, reset_between: true) do
      cms_login_page_comps.button_signin.click
      # Navigates user through the DfE sign-in flow to the "My Cases" page
      world.shared_global_methods.complete_dfe_signin_as(user, environment)

      # Complete the login process and lands on my cases
      expect(page).to have_current_path(%r{/support#my-cases}, url: true, wait: 20)
      wait_for_element_to_include(cms_mycases_page_comps.text_page_heading, "My cases", timeout: 2)

      puts "[INFO] Successfully signed in as Proc Ops Admin user"
    end
  end

  def continue_as_signed_in_user_to_which_school
    # start to before you start page
    energy_start_comps.button_start_now.click
    expect(page).to have_current_path(%r{/before-you-start}, url: true, wait: 2)
    wait_for_element_to_include(energy_before_you_start_comps.text_page_heading, "Before you start", timeout: 2)

    # Move from before you start to school selection
    energy_before_you_start_comps.button_continue.click
    expect(page).to have_current_path(%r{/which-school-buying-for}, url: true, wait: 2)
    expect(energy_which_school_buying_for_comps.text_page_heading.text).to include("Which school are you buying for?")
  end

  def sign_out_of_cms
    cms_top_nav_comps.link_sign_out.click
    expect(page).to have_current_path(%r{/cms/sign-in}, url: true, wait: 2)
    expect(cms_login_page_comps.text_flash_notice.text).to include("You have been signed out.")
  end

private

  def defensive_login_retry(max_attempts: 3, sleep_s: 2, reset_between: true)
    attempts = 0

    begin
      attempts += 1
      yield
      true
    rescue Selenium::WebDriver::Error::UnknownError,
           Selenium::WebDriver::Error::StaleElementReferenceError,
           RSpec::Expectations::ExpectationNotMetError,
           Capybara::ExpectationNotMet => e

      raise if attempts >= max_attempts

      msg = e.message.to_s
      puts "[WARN] Login retry (attempt #{attempts}/#{max_attempts}) after error: #{msg.lines.first.strip}"

      reset_session! if reset_between
      sleep sleep_s
      retry
    end
  end
end
