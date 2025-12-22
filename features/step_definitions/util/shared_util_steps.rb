# frozen_string_literal: true

Given(/^we open and login to the test signin orgs management area$/) do
  test_user_management_util_methods.open_test_manage_users_screen
end

Given(/^we select org (.*) to add a user too$/) do |org|
  test_user_management_util_methods.select_org_to_add_user_too(org)
end

When(/^we add first name "([^"]*)" last name "([^"]*)" email "([^"]*)" to associate with the org$/) do |first_name, last_name, email|
  test_user_management_util_methods.complete_invite_user_to_permissions_page(first_name, last_name, email)
end

And(/^we set their permission level to "([^"]*)"$/) do |level|
  test_user_management_util_methods.permission_to_completion(level)
end

Then(/^we see the confirmation message showing the user "([^"]*)" has been added to the org$/) do |user_email|
  test_user_management_util_methods.review_details_to_completion(user_email)
end