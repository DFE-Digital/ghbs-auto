# frozen_string_literal: true

Given("we are logged in to the Energy Onboarding Flow as a {word} School user") do |user|
  energy_signin_flow_methods.continue_to_before_you_start_page
  energy_signin_flow_methods.continue_to_access_dfe_signin_page
  energy_signin_flow_methods.continue_complete_dfe_signin_flow_v2(user, "dev")
end

And(/^we complete the login and school selection process with user (.*) and school (.*)$/) do |user, school_name|
  # Sign-in
  energy_signin_flow_methods.continue_to_before_you_start_page
  energy_signin_flow_methods.continue_to_access_dfe_signin_page
  energy_signin_flow_methods.continue_complete_dfe_signin_flow_v2(user, "dev")

  # School Selection
  energy_school_selection_methods.select_school(school_name)
  energy_school_selection_methods.continue_to_are_you_authorised_page
end