# frozen_string_literal: true

Given(/^we open and login to the cec screens as an admin in the dev environment$/) do
  cms_signin_flow_methods.open_cms_cec_homepage
  cms_signin_flow_methods.validate_homepage_loaded
end
