# frozen_string_literal: true

require "pages/energy/energy_base_page"
require "components/energy/completion/energy_loa_comps"
require "components/energy/completion/energy_info_submitted_comps"
class EnergyLoaMethods < EnergyBasePage
  def complete_loa
    energy_loa_comps.checkbox_1.click
    energy_loa_comps.checkbox_2.click
    energy_loa_comps.checkbox_3.click
  end

  def continue_to_information_submitted
    energy_loa_comps.button_continue.click
  end
end
