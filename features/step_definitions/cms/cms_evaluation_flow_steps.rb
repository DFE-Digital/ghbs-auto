# frozen_string_literal: true

When(/^we complete the evaluation flow upto and including the email sending$/) do
  cms_case_evaluation_flow_methods.complete_initial_eval_setup_proc_ops_side
end

And(/^login and complete the school facing evaluation flow as the school user$/) do
  cms_case_evaluation_school_user_flow_methods.open_current_case_evaluation_for_school_user
  cms_case_evaluation_school_user_flow_methods.complete_download_documents
  cms_case_evaluation_school_user_flow_methods.complete_upload_evaluation_scoring_docs
end

Then(/^we confirm the notification to the proc ops user has been sent$/) do
  cms_notifications_methods.validate_notification_from_evaluation_has_arrived
end

And(/^the ProcOps user will be able to validate school users evaluation$/) do
  cms_case_evaluation_flow_methods.complete_review_evaluations
end
