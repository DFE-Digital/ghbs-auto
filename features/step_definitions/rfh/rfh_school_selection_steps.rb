# frozen_string_literal: true

And(/^I select a school with the type of "([^"]*)"$/) do |org_type|
  rfh_school_selection_methods.set_org_type(org_type)
  rfh_school_selection_methods.process_data_for_school_selection(org_type)
end

And(/^as a logged in user I confirm our "([^"]*)" school is correct$/) do |user_type|
  rfh_sign_in_methods.validate_logged_in_user_details(user_type)
  rfh_logged_in_school_selection_methods.complete_which_school_are_you_buying_for(user_type)
end
