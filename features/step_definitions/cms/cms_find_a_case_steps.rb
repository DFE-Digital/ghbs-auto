# frozen_string_literal: true

Given(/^we find and open case "([^"]*)" via the cms find a case screen$/) do |term|
  cms_top_nav_methods.nav_to_find_a_case_screen
  cms_find_a_case_methods.search_for_case(term)
  cms_find_a_case_methods.open_returned_result_with_case_number(term)
end
