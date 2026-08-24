# frozen_string_literal: true

Given(/^we open the Savings options for schools buying option via the homepage$/) do
  fabs_banking_methods.open_the_dfe_featured_savings_options_for_schools
end

When(/^we open and validate the links out of the saving options page$/) do
  fabs_banking_methods.validate_the_correct_links_on_the_savings_options_page
end

And(/^we open and validate the links out of the Insignis savings platform page$/) do
  fabs_banking_methods.validate_the_correct_links_on_the_insignis_page
end

Then(/^finally we validate the links on the Current accounts for schools page$/) do
  fabs_banking_methods.validate_the_correct_links_on_the_current_accounts_page
end
