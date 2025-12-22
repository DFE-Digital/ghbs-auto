# frozen_string_literal: true

require "components/dfe_signin/dfe_signin_access_the_service_page_comps"
require "components/dfe_signin/dfe_signin_enter_your_password_page_comps"
require "components/dfe_signin/dfe_signin_enter_code_comps"
require "components/dfe_signin/dfe_signin_verify_your_identity_comps"
require "components/dfe_signin/user_management/dfe_signin_1_manage_users_comps"
require "components/dfe_signin/user_management/dfe_signin_2_select_your_org_comps"
require "components/dfe_signin/user_management/dfe_signin_3_invite_user_comps"
require "components/dfe_signin/user_management/dfe_signin_4_permission_level_comps"
require "components/dfe_signin/user_management/dfe_signin_5_select_services_comps"
require "components/dfe_signin/user_management/dfe_signin_6_review_invite_details_comps"

module SharedDfeSignInComps
  # Dfe Signin pages
  def dfe_signin_access_the_service_page_comps = @dfe_signin_access_the_service_page_comps ||= DfeSigninAccessTheServicePageComps.new
  def dfe_signin_enter_your_password_page_comps = @dfe_signin_enter_your_password_page_comps ||= DfeSigninEnterYourPasswordPageComps.new
  def dfe_signin_enter_code_comps = @dfe_signin_enter_code_comps ||= DfeSigninEnterCodeComps.new
  def dfe_signin_verify_your_identity_comps = @dfe_signin_verify_your_identity_comps ||= DfeSigninVerifyYourIdentityComps.new

  # Dfe Test User Management Pages
  def dfe_signin_1_manage_users_comps = @dfe_signin_1_manage_users_comps ||= DfeSignin1ManageUsersComps.new
  def dfe_signin_2_select_your_org_comps = @dfe_signin_2_select_your_org_comps ||= DfeSignin2SelectYourOrgComps.new
  def dfe_signin_3_invite_user_comps = @dfe_signin_3_invite_user_comps ||= DfeSignin3inviteUserComps.new
  def dfe_signin_4_permission_level_comps = @dfe_signin_4_permission_level_comps ||= DfeSignin4PermissionLevelComps.new
  def dfe_signin_5_select_services_comps = @dfe_signin_5_select_services_comps ||= DfeSignin5SelectServicesComps.new
  def dfe_signin_6_review_invite_details_comps = @dfe_signin_6_review_invite_details_comps ||= DfeSignin6ReviewInviteDetailsComps.new

end
