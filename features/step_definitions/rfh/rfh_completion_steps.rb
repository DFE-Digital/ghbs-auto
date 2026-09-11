# frozen_string_literal: true

And(/^I complete the remaining screens up to and including the Send your request screen$/) do
  rfh_completion_methods.complete_access_needs_screen
  rfh_completion_methods.complete_how_did_you_find_screen
  rfh_completion_methods.complete_and_validate_send_your_request_screen
end

Then(/^I successfully arrive on the Request sent screen$/) do
  rfh_completion_methods.complete_and_validate_your_request_for_support_has_been_sent
end

And(/^I complete the upload screens up to and including the Send your request screen$/) do
  rfh_upload_methods.complete_any_docs_to_share_with_us
  rfh_upload_methods.complete_upload_your_docs
  rfh_upload_methods.complete_your_files_have_been_uploaded
  rfh_completion_methods.complete_access_needs_screen
  rfh_completion_methods.complete_how_did_you_find_screen
  rfh_completion_methods.complete_and_validate_send_your_request_screen
end

And(/^I complete the energy specific upload screens including the Send your request screen$/) do
  rfh_energy_methods.complete_recent_energy_bill_upload_screen
  rfh_energy_methods.complete_upload_your_energy_info
  rfh_energy_methods.complete_your_energy_files_have_been_uploaded
  rfh_completion_methods.complete_access_needs_screen
  rfh_completion_methods.complete_how_did_you_find_screen
  rfh_completion_methods.complete_and_validate_send_your_request_screen
end
