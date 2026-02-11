# frozen_string_literal: true

Then(/^we validate that the "([^"]*)" has the correct access within the cms system$/) do |role|
  cms_role_based_access_methods.validate_visible_screens_based_on_user_type(role)
end

Given(/^we set out "([^"]*)" to have a role of "([^"]*)" from the Agents screen$/) do |target_user, role|
  cms_top_nav_methods.nav_to_management_screen
  cms_role_based_access_methods.nav_to_agents_screen
  cms_role_based_access_methods.set_single_role_based_permission(target_user, role)
end
