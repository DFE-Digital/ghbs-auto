# frozen_string_literal: true

require "uri"
require "components/energy/journey_start/energy_are_you_authorised_comps"
require "components/energy/journey_start/energy_what_are_you_switching_comps"

class EnergyAreYouAuthorisedPageMethods < EnergyBasePage
  def continue_to_what_are_switching_page
    # Ok so there is a small chance we could land on a page here which is for an in flight case, ie /task-list
    # if this is the case we need to dig ourselves out of this position and reset our data!

    path = wait_until_authorisation_or_tasklist_if_on_school_picker(timeout: 7)
    puts "[DEBUG] full path after settle: #{path}"

    if path.include?("/authorisation")
      puts "[INFO] On /authorisation — continue as normal"
      expect(page).to have_current_path(%r{/authorisation}, url: true, wait: 10)
      expect(energy_are_you_authorised_comps.text_page_heading.text).to include("Are you authorised to switch energy suppliers for these schools?")

    elsif path.include?("/task-list") || path.include?("/which-energy-supply")
      puts "[INFO] On /task-list — handle reset flow"
      # Open the CEC CMS Find a case screen
      world.cms_signin_flow_methods.open_cms_cec_find_a_case_screen

      # Search and identify the open and record
      world.cms_find_a_case_methods.search_for_case(case_state.school_name)
      world.cms_find_a_case_methods.open_first_active_status_result_with_case_number_for_current_user

      # Close the active record
      world.cms_case_actions_methods.complete_resolve_case_flow

      # Return back to what should be the authorisation page
      world.energy_start_page_methods.open_energy_start_page
      world.energy_start_page_methods.validate_start_page_loaded
      world.cms_signin_flow_methods.continue_as_signed_in_user_to_which_school
      world.energy_school_selection_methods.select_school(case_state.school_name)
      world.energy_school_selection_methods.continue_to_are_you_authorised_page
    else
      puts "[INFO] Unknown path '#{path}', skipping optional logic"
    end

    # Navigates user from the "Are you authorised to switch energy suppliers for these schools?" page to the "Are you switching electric, gas or both?" page
    energy_are_you_authorised_comps.button_continue.click
    expect(page).to have_current_path(%r{/which-energy-supply}, url: true, wait: 10)
    expect(energy_what_are_you_switching_comps.text_page_heading.text).to include("Are you switching electricity, gas or both?")
  end

private

  def wait_until_authorisation_or_tasklist_if_on_school_picker(timeout: 7)
    path = URI.parse(current_url).path.to_s

    return path unless path.include?("/which-school-buying-for")

    puts "[INFO] On /which-school-buying-for — waiting (up to #{timeout}s) for /authorisation or /task-list…"
    begin
      Capybara.using_wait_time(timeout) do
        expect(page).to have_current_path(%r{/(authorisation|task-list)}, url: true)
      end
    rescue RSpec::Expectations::ExpectationNotMetError
      puts "[WARN] Still not on /authorisation or /task-list after #{timeout}s (current: #{current_url})"
    end

    URI.parse(current_url).path.to_s
  end
end
