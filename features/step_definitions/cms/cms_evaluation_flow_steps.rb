# frozen_string_literal: true

When(/^we complete the evaluation flow upto and including the email sending$/) do
  cms_case_evaluation_flow_methods.complete_initial_eval_setup_proc_ops_side
end
