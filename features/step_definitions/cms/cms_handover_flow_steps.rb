# frozen_string_literal: true

When(/^we complete the handover flow upto and including the email sending$/) do
  cms_case_handover_flow_methods.complete_initial_handover_setup_proc_ops_side
end

And(/^login and complete the school facing handover flow as the school user$/) do
  cms_case_handover_school_user_flow_methods.open_current_case_handover_for_school_user
  cms_case_handover_school_user_flow_methods.complete_download_documents
end

Then(/^we validate the completion of the Download contract section in the cms$/) do
  pending
end
