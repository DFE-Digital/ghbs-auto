# frozen_string_literal: true

require "components/dfe_signin/dfe_signin_access_the_service_page_comps"
require "components/dfe_signin/dfe_signin_enter_your_password_page_comps"
require "components/dfe_signin/dfe_signin_enter_code_comps"
require "components/dfe_signin/dfe_signin_verify_your_identity_comps"

module SharedDfeSignInComps
  # Dfe Signin pages
  def dfe_signin_access_the_service_page_comps = @dfe_signin_access_the_service_page_comps ||= DfeSigninAccessTheServicePageComps.new
  def dfe_signin_enter_your_password_page_comps = @dfe_signin_enter_your_password_page_comps ||= DfeSigninEnterYourPasswordPageComps.new
  def dfe_signin_enter_code_comps = @dfe_signin_enter_code_comps ||= DfeSigninEnterCodeComps.new
  def dfe_signin_verify_your_identity_comps = @dfe_signin_verify_your_identity_comps ||= DfeSigninVerifyYourIdentityComps.new
end
