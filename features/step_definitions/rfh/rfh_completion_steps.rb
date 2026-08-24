# frozen_string_literal: true

And(/^I complete the remaining screens up to and including the Send your request screen$/) do
  rfh_completion_methods.complete_access_needs_screen
  rfh_completion_methods.complete_how_did_you_find_screen
  rfh_completion_methods.complete_and_validate_send_your_request_screen
end

Then(/^I successfully arrive on the Request sent screen$/) do
  rfh_completion_methods.complete_and_validate_your_request_for_support_has_been_sent
end
