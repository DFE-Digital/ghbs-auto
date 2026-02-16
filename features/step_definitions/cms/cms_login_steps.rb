# frozen_string_literal: true

Given(/^we open and login to the cec screens as an admin in the dev environment$/) do
  cms_signin_flow_methods.open_cms_cec_homepage
  cms_signin_flow_methods.validate_cms_homepage_loaded
  cms_signin_flow_methods.continue_and_complete_dfe_signin_as_cec_admin
end

Given(/^we open and login to the proc ops CMS screens as an admin in the dev environment$/) do
  cms_signin_flow_methods.open_cms_proc_ops_homepage
  cms_signin_flow_methods.validate_cms_homepage_loaded
  cms_signin_flow_methods.continue_and_complete_dfe_signin_as_any_cms_user_type("global", "dev", "global")
end

And(/^we log out and log back in as our "([^"]*)"$/) do |target_user|
  cms_signin_flow_methods.sign_out_of_cms
  cms_signin_flow_methods.validate_cms_homepage_loaded
  cms_signin_flow_methods.continue_and_complete_dfe_signin_as_any_cms_user_type(target_user, "dev")
end

And(/^we log out and log back in as our "([^"]*)" who has the role of "([^"]*)"$/) do |target_user, role|
  cms_signin_flow_methods.sign_out_of_cms
  cms_signin_flow_methods.validate_cms_homepage_loaded
  cms_signin_flow_methods.continue_and_complete_dfe_signin_as_any_cms_user_type(target_user, "dev", role)
end
