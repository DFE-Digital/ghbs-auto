# frozen_string_literal: true

Given("I validate the footer pages are loading correctly") do
  fabs_nav_methods.navigate_to_terms_and_conditions_page
  fabs_nav_methods.navigate_to_accessibility_statement_page
end

Given("I validate the category flow pages are loading correctly") do
  fabs_nav_methods.navigate_to_first_available_category_page
  fabs_nav_methods.navigate_to_first_available_buying_option_page
end

Given("I validate the search and buying option pages are loading correctly") do
  # nav_methods.navigate_to_all_buying_options_page
  fabs_nav_methods.navigate_to_search_page
end

Then("finally I validate the error pages are loading correctly") do
  fabs_nav_methods.navigate_to_404_page
  fabs_nav_methods.navigate_to_500_page
end
