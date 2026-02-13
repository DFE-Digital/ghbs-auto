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
require "components/cms/cms_case_statistics_comps"
require "components/cms/frameworks/cms_frameworks_register_comps"

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

  def continue_and_complete_dfe_signin_as_any_cms_user_type(user, environment, role = nil)
    # Set current_case_state
    current_user_state.user = user
    current_user_state.role = role
    current_user_state.env = environment

    # Retrieve the current url in case we need to retry login
    return_url = page.current_url

    defensive_login_retry(max_attempts: 3, sleep_s: 10, reset_between: false) do |attempt|
      restore_start_state(attempt: attempt, return_url: return_url)

      cms_login_page_comps.button_signin.click
      # Navigates user through the DfE sign-in flow to the "My Cases" page
      world.shared_global_methods.complete_dfe_signin_as(user, environment)
      # Complete the login process and lands on my cases
      if ["Engagement and Outreach Admin", "Engagement and Outreach Staff Member"].include?(role)
        expect(page).to have_current_path(%r{/engagement#my-cases}, url: true, wait: 20)
        wait_for_element_to_include(cms_mycases_page_comps.text_page_heading, "My cases", timeout: 10)
      elsif ["CEC Staff Member", "CEC Admin"].include?(role)
        expect(page).to have_current_path(%r{/cec#my-cases}, url: true, wait: 20)
        wait_for_element_to_include(cms_mycases_page_comps.text_page_heading, "My cases", timeout: 10)
      elsif ["Data Analyst"].include?(role)
        expect(page).to have_current_path(%r{/support/case_statistics#stats-by-person}, url: true, wait: 20)
        wait_for_element_to_include(cms_case_statistics_comps.text_page_heading, "Case statistics", timeout: 10)
      elsif ["Framework Evaluator Admin", "Framework Evaluator"].include?(role)
        expect(page).to have_current_path(%r{/frameworks#frameworks-register}, url: true, wait: 20)
        wait_for_element_to_include(cms_frameworks_register_comps.text_page_heading, "Frameworks Register", timeout: 10)
      else
        expect(page).to have_current_path(%r{/support#my-cases}, url: true, wait: 20)
        wait_for_element_to_include(cms_mycases_page_comps.text_page_heading, "My cases", timeout: 10)
      end

      puts "[INFO] Successfully signed in as #{role} user"
    end
  end

  def restore_start_state(attempt:, return_url:)
    attempt = attempt.to_i
    return if attempt <= 1

    puts "[INFO] Restoring start state (attempt #{attempt})"

    if attempt == 2
      page.refresh
    else
      Capybara.reset_sessions!
      visit return_url
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

  def defensive_login_retry(max_attempts:, sleep_s:, reset_between: false)
    attempt = 0
    last_error = nil

    while attempt < max_attempts
      attempt += 1

      begin
        yield
        return # success
      rescue Selenium::WebDriver::Error::UnknownError,
             Selenium::WebDriver::Error::StaleElementReferenceError,
             Selenium::WebDriver::Error::InvalidSessionIdError,
             Capybara::ElementNotFound,
             Capybara::ExpectationNotMet => e

        last_error = e
        puts "[WARN] Login retry (attempt #{attempt}/#{max_attempts}) after error: #{e.class}: #{e.message}"

        # if we've used up our attempts, re-raise with original error
        raise if attempt >= max_attempts

        if reset_between
          begin
            Capybara.reset_sessions!
          rescue StandardError => reset_err
            puts "[WARN] Capybara.reset_sessions! raised #{reset_err.class}: #{reset_err.message}"
          end
        end

        sleep sleep_s
        next
      end
    end

    raise last_error if last_error
  end
end
