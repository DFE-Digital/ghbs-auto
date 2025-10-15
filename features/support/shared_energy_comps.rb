# frozen_string_literal: true

require "components/energy_start_page_comps"

module SharedEnergyComps
  # Pre Flow Pages
  def energy_start_page_comps = @energy_start_page_comps ||= EnergyStartPageComps.new
end
