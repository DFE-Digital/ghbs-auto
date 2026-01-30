# frozen_string_literal: true

Given(/^we navigate to a simple Buying option via a buying category$/) do
  fabs_breadcrumb_methods.navigate_to_a_simple_buying_option_via_buying_category
end

Then(/^the buying category will show the breadcrumbs associated with a simple view$/) do
  fabs_breadcrumb_methods.validate_the_breadcrumbs_on_the_buying_option_for_simple
end

Given(/^we navigate to a complex Buying option via its assigned parent a buying category$/) do
  fabs_breadcrumb_methods.navigate_to_complex_buying_option_via_parent
end

And(/^the buying option will show the breadcrumbs associated with its assigned parent$/) do
  fabs_breadcrumb_methods.validate_the_breadcrumbs_on_the_buying_option_via_parent
end

When(/^we then access the same page from a none parent page$/) do
  fabs_breadcrumb_methods.navigate_to_complex_buying_option_via_non_parent
end

Then(/^the page will show the none parent breadcrumb its associated with$/) do
  fabs_breadcrumb_methods.validate_the_breadcrumbs_on_the_buying_option_via_non_parent
end
