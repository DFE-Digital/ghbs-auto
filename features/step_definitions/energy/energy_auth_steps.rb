# frozen_string_literal: true

Given("we are logged in to the Energy Onboarding Flow as a {word} School user") do |user|
  energy_signin_flow_methods.continue_to_before_you_start_page
  energy_signin_flow_methods.continue_to_access_dfe_signin_page
  energy_signin_flow_methods.continue_complete_dfe_signin_flow(user)
end
