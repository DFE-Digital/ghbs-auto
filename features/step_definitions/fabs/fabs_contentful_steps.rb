# frozen_string_literal: true

Given(/^we are logged in to Contentful with publishing permissions$/) do
  contentful_login_methods.login_to_contentful
  contentful_login_methods.change_to_the_test_env
end

When(/^we update the "([^"]*)" frameworks title and content$/) do |framework_name|
  contentful_edit_solution_methods.open_auto_solution_page_and_edit_content(framework_name)
end

And(/^we validate this change has appeared on the Contentful API$/) do
  pending
end
