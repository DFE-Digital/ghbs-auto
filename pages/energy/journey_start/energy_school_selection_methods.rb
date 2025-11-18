# frozen_string_literal: true

require "pages/shared/shared_global_methods"
require "pages/energy/energy_base_page"
require "components/energy/journey_start/energy_which_school_buying_for_comps"
require "components/energy/journey_start/energy_are_you_authorised_comps"

class EnergySchoolSelectionMethods < EnergyBasePage
  def select_school(school_name)
    expect(page).to have_current_path(%r{/which-school-buying-for}, url: true, wait: 10)
    energy_which_school_buying_for_comps.radio_select_desired_school(school_name).click

    # Add to case state
    case_state.school_name = school_name
  end

  def continue_to_are_you_authorised_page
    # Navigates user from the "Which school are you buying for?" page to the "Are you authorised to switch energy suppliers for these schools?" page
    energy_which_school_buying_for_comps.button_continue.click
    # expect(page).to have_current_path(%r{/authorisation}, url: true, wait: 10)
    # expect(energy_are_you_authorised_comps.text_page_heading.text).to include("Are you authorised to switch energy suppliers for these schools?")
  end
end
