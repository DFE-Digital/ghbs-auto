# frozen_string_literal: true

Given(/^we navigate to a simple Buying option via a buying category$/) do
  fabs_breadcrumb_methods.navigate_to_a_simple_buying_option_via_buying_category
end

Then(/^the buying category will show the breadcrumbs associated with a simple view$/) do
  fabs_breadcrumb_methods.validate_the_breadcrumbs_on_the_buying_option_for_simple
end

