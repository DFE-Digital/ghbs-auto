# frozen_string_literal: true

And(/^I select a school with the type of "([^"]*)"$/) do |org_type|
  rfh_school_selection_methods.set_org_type(org_type)
  rfh_school_selection_methods.process_data_for_school_selection(org_type)
end
