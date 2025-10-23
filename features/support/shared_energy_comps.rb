# frozen_string_literal: true

require "components/energy/energy_start_page_comps"
require "components/energy/energy_before_you_start_page_comps"
require "components/dfe_signin/dfe_signin_access_the_service_page_comps"
require "components/dfe_signin/dfe_signin_enter_your_password_page_comps"
require "components/energy/energy_which_school_buying_for_comps"

module SharedEnergyComps
  # Pre Flow pages
  def energy_start_page_comps = @energy_start_page_comps ||= EnergyStartPageComps.new
  def energy_before_you_start_page_comps = @energy_before_you_start_page_comps ||= EnergyBeforeYouStartPageComps.new

  # Dfe Signin pages
  def dfe_signin_access_the_service_page_comps = @dfe_signin_access_the_service_page_comps ||= DfESignInAccessTheServicePageComps.new
  def dfe_signin_enter_your_password_page_comps = @dfe_signin_enter_your_password_page_comps ||= DfESignInEnterYourPasswordPageComps.new

  # School selection and validation pages
  def energy_which_school_buying_for_comps = @energy_which_school_buying_for_comps ||= EnergySchoolSelectionPageComps.new

end
