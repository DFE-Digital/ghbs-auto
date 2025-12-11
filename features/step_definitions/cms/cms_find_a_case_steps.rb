# frozen_string_literal: true

Given(/^we find and open case "([^"]*)" via the cms find a case screen$/) do |term|
  cms_top_nav_methods.nav_to_find_a_case_screen
  cms_find_a_case_methods.search_for_case(term)
  cms_find_a_case_methods.open_returned_result_with_case_number(term)
end

Given(/^we find and open the first in flight case we come across for "([^"]*)"$/) do |org_name|
  cms_top_nav_methods.nav_to_find_a_case_screen
  cms_find_a_case_methods.search_for_case(org_name)
  cms_find_a_case_methods.open_first_active_status_result_with_case_number_for_current_user
end

Given(/^we find and search for any cases for "([^"]*)"$/) do |org_name|
  cms_top_nav_methods.nav_to_find_a_case_screen
  cms_find_a_case_methods.search_for_case(org_name)
end

When(/^we set the filter status to be "([^"]*)"$/) do |option|
  cms_find_a_case_methods.set_filter_by_status(option)
end
