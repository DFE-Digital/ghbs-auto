# frozen_string_literal: true

require "components/energy/energy_start_page_comps"
require "components/energy/energy_before_you_start_page_comps"
require "components/energy/energy_which_school_buying_for_comps"
require "components/energy/energy_are_you_authorised_comps"
require "components/energy/energy_what_are_you_switching_comps"

module SharedEnergyComps
  # Pre Flow pages
  def energy_start_page_comps = @energy_start_page_comps ||= EnergyStartPageComps.new
  def energy_before_you_start_page_comps = @energy_before_you_start_page_comps ||= EnergyBeforeYouStartPageComps.new

  # School selection and validation pages
  def energy_which_school_buying_for_comps = @energy_which_school_buying_for_comps ||= EnergySchoolSelectionPageComps.new
  def energy_are_you_authorised_comps = @energy_are_you_authorised_comps ||= EnergyAreYouAuthorisedPageComps.new

  # Gas / Electricity Pages
  def energy_what_are_you_switching_comps = @energy_what_are_you_switching_comps ||= EnergyWhatAreYouSwitchingPageComps.new
end
