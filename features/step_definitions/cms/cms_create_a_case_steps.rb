# frozen_string_literal: true

Given(/^we create a new case and set it to a level (.*) case$/) do |arg|
  cms_create_a_new_case_methods.create_a_new_case_with_unique_data
end
