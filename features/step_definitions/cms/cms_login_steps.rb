# frozen_string_literal: true

Given(/^we open and login to the cec screens as an admin in the dev environment$/) do
  cms_signin_flow_methods.open_cms_cec_homepage
  cms_signin_flow_methods.validate_cms_homepage_loaded
  cms_signin_flow_methods.continue_and_complete_dfe_signin
end
