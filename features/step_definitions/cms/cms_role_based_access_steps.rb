# frozen_string_literal: true

Given(/^we set our "([^"]*)" to have Procurement Operations Admin from the Agents screen$/) do |target_user|
  cms_top_nav_methods.nav_to_management_screen
  cms_role_based_access_methods.nav_to_agents_screen
  cms_role_based_access_methods.set_single_role_based_permission(target_user, "Procurement Operations Admin")
end

Then(/^we validate that the Procurement Operations Admin has the correct access$/) do
  pending
end
