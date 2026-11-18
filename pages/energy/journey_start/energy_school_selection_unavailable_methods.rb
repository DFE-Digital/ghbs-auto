# frozen_string_literal: true

require "pages/shared/shared_global_methods"
require "pages/energy/energy_base_page"
require "components/energy/journey_start/energy_school_selection_unavailable_comps"
require "helpers/validation_helpers"

class EnergySchoolSelectionUnavailableMethods < EnergyBasePage
  include ValidationHelpers
  def confirm_individual_schools_only_page
    expect(page).to have_current_path(%r{/school-selection-unavailable/}, url: true, wait: 10)
    expect(energy_school_selection_unavailable_comps.text_page_heading.text).to include("Service only available for individual schools")

    # Confirm RYI link is present
    expect(element_present?(energy_school_selection_unavailable_comps.xpath_link_ryi)).to be(true)
  end
end
