# frozen_string_literal: true

Given("we navigate to the RFH start page") do
  rfh_sign_in_methods.nav_to_rfh_start_page
end

Given("I complete the RFH login as a user type of {string}") do |user_type|
  rfh_sign_in_methods.start_the_rfh_flow
  rfh_sign_in_methods.complete_login_as_x_user(user_type)
end
