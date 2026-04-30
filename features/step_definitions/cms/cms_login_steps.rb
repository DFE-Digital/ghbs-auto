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

And(/^we navigate to the cms system to find our energy case$/) do
  # Sign in to cms
  cms_signin_flow_methods.open_cms_proc_ops_homepage
  cms_signin_flow_methods.validate_cms_homepage_loaded
  cms_signin_flow_methods.continue_and_complete_dfe_signin_as_any_cms_user_type("global", "dev", "global")

  # Search for our case
  cms_top_nav_methods.nav_to_find_a_case_screen
  cms_find_a_case_methods.search_for_case(case_state.case_number)
  cms_find_a_case_methods.validate_results_for_case_id(case_state.case_number, case_state.school_name)
  cms_find_a_case_methods.open_returned_result_with_case_number(case_state.case_number)
end
