# frozen_string_literal: true

require "pages/shared_global_methods"
require "pages/energy/energy_base_page"
require "components/energy/journey_start/energy_what_are_you_switching_comps"

class EnergySwitchingSelectionMethods < EnergyBasePage
  def choose_switch(choice)
    expect(page).to have_current_path(%r{/which-energy-supply}, url: true, wait: 10)

    case choice
    when "gas only"
      energy_what_are_you_switching_comps.radio_gas_only.click
    when "electricity only"
      energy_what_are_you_switching_comps.radio_electric_only.click
    when "both"
      energy_what_are_you_switching_comps.radio_both_electric_and_gas.click
    end

  end

  def continue_to_your_chosen_selection_path
    # Navigates to chosen path, normally we would check the next page here, however it may vary depending on your chocie. hence we just navigate there and do the check on the next page.
    energy_what_are_you_switching_comps.button_save_and_continue.click
  end
end
