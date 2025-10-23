# frozen_string_literal: true

Given("we open and validate the start of the energy onboarding flow") do
  energy_start_page_methods.open_energy_start_page
  energy_start_page_methods.validate_start_page_loaded
end

And(/^we select (.*) from the bullet list and start the onboarding journey$/) do |school_name|
  energy_school_selection_methods.select_school(school_name)
  energy_school_selection_methods.continue_to_are_you_authorised_page
end

When(/^the (.*) option is selected and completed$/) do |switching_method|
  energy_are_you_authorised_page_methods.continue_to_what_are_switching_page
end
