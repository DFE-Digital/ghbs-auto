# frozen_string_literal: true

Then(/^we validate that the "([^"]*)" has the correct access within the cms system$/) do |role|
  cms_role_based_access_methods.validate_visible_screens_based_on_user_type(role)
end

Given(/^we set out "([^"]*)" to have a role of "([^"]*)" from the Agents screen$/) do |target_user, role|
  cms_top_nav_methods.nav_to_management_screen
  cms_role_based_access_methods.nav_to_agents_screen
  cms_role_based_access_methods.set_single_role_based_permission(target_user, role)
end

Then(/^we validate that the current user has the correct Agents screen permissions$/) do
  cms_top_nav_methods.nav_to_management_screen
  cms_role_based_access_methods.nav_to_agents_screen
  cms_rba_admin_agents_methods.open_and_validate_new_agents_list
end

Then(/^we validate that the "([^"]*)" has the correct Find a Case permissions$/) do |arg|
  pending
end

And(/^we validate that the "([^"]*)" has the correct MyCases permissions$/) do |arg|
  pending
end
