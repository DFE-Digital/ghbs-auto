# frozen_string_literal: true

Then(/^we complete the actions to either Close or Resolve the case$/) do
  cms_case_actions_methods.complete_resolve_case_flow
end

Then(/^we complete the actions to either Close or Resolve any open cases$/) do
  cms_case_actions_methods.complete_and_close_all_open_cases
end

And(/^we assign our current case worker to the case$/) do
  cms_case_actions_methods.assign_current_case_worker_to_case
end

When(/^I complete the case lifecycle actions I will see the status change:$/) do |table|
  table.hashes.each do |row|
    action = row["action"]
    expected_status = row["expected_status"]

    cms_case_states_methods.switch_case_states(action, expected_status)
  end
end
