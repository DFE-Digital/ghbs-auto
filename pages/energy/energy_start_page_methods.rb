# frozen_string_literal: true

require "pages/energy/energy_base_page"
require "components/energy/energy_start_page_comps"

class EnergyStartPageMethods < EnergyBasePage
  def open_energy_start_page
    visit SECRETS["dev_energy_onboarding_homepage_url"]
  end

  def validate_start_page_loaded
    expect(energy_start_page_comps.text_page_heading.text)
      .to include("Join Energy for Schools")
  end
end
