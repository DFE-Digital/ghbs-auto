# frozen_string_literal: true

Given(/^we create a new case and set it to a level (.*) case$/) do |case_level|
  cms_create_a_new_case_methods.create_a_new_case_with_unique_data
  cms_create_a_new_case_methods.change_case_level_to(case_level)
end
