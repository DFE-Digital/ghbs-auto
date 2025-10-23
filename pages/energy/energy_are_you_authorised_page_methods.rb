# frozen_string_literal: true

require "pages/shared_global_methods"
require "pages/energy/energy_base_page"
require "components/energy/energy_are_you_authorised_comps"
require "components/energy/energy_what_are_you_switching_comps"

class EnergyAreYouAuthorisedPageMethods < EnergyBasePage

  def continue_to_what_are_switching_page
    # Navigates user from the "Are you authorised to switch energy suppliers for these schools?" page to the "Are you switching electricity, gas or both?" page
    energy_are_you_authorised_comps.button_continue.click
    expect(page).to have_current_path(%r{/which-energy-supply}, url: true, wait: 10)
    expect(energy_what_are_you_switching_comps.text_page_heading.text).to include("Are you switching electricity, gas or both?")
  end

end
