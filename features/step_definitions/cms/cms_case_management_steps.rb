# frozen_string_literal: true

Then(/^we complete the actions to either Close or Resolve the case$/) do
  cms_case_actions_methods.complete_resolve_case_flow
end
