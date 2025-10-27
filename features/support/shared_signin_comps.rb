# frozen_string_literal: true
require "components/dfe_signin/dfe_signin_access_the_service_page_comps"
require "components/dfe_signin/dfe_signin_enter_your_password_page_comps"

module SharedDfeSignInComps

  # Dfe Signin pages
  def dfe_signin_access_the_service_page_comps = @dfe_signin_access_the_service_page_comps ||= DfESignInAccessTheServicePageComps.new
  def dfe_signin_enter_your_password_page_comps = @dfe_signin_enter_your_password_page_comps ||= DfESignInEnterYourPasswordPageComps.new

end
