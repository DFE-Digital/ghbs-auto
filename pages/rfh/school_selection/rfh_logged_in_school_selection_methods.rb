# frozen_string_literal: true

require "pages/shared/shared_global_methods"
require "pages/rfh/rfh_base_page"
require "components/rfh/school_selection/rfh_which_school_are_you_buying_for_comps"
require "helpers/validation_helpers"
require "helpers/logger_helpers"
require "helpers/unique_content_helpers"

class RfhLoggedInSchoolSelectionMethods < RfhBasePage
  include ValidationHelpers
  include LoggerHelpers
  include UniqueContentHelpers

  def complete_which_school_are_you_buying_for(user_type)
    # Confirm we are on the "Which school are you buying for?" screen
    expect(page).to have_current_path(%r{/procurement-support/select_organisation}, url: true, wait: 10)
    expect(rfh_which_school_are_you_buying_for_comps.text_page_heading.text).to include("Which school are you buying for?")

    # Select SAT school (ALCESTER GRAMMAR SCHOOL = Group type:	Single-academy trust)
    if user_type == "Single Academy Trust"
      rfh_which_school_are_you_buying_for_comps.radio_org_name("ALCESTER GRAMMAR SCHOOL").click
    end

    rfh_state.single_or_multi = "single"
    rfh_state.school_name = "ALCESTER GRAMMAR SCHOOL"
    rfh_state.org_name = "ALCESTER GRAMMAR SCHOOL"
    rfh_state.school_type_1 = "Single-academy Trust"
    rfh_state.schools_your_buying_for = "1 of 1 schools" # normally we would calculate this for a MAT but this is a SAT hence is locked.

    # Move on to the next screen
    rfh_which_school_are_you_buying_for_comps.button_continue.click
  end
end
