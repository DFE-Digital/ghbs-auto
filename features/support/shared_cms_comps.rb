# frozen_string_literal: true

require "components/cms/cms_login_page_comps"
require "components/cms/cms_mycases_page_comps"
require "components/cms/cms_top_nav_comps"
require "components/cms/find_a_case/cms_find_a_case_page_comps"
require "components/cms/cms_notifications_page_comps"
require "components/cms/find_a_case/cms_search_results_page_comps"
require "components/cms/case/cms_single_case_view_page_comps"
require "components/cms/case/actions/cms_single_case_resolve_case_page_comps"
require "components/cms/case/actions/cms_single_case_assign_to_case_worker_comps"
require "components/cms/case/cms_single_case_actions_comps"
require "components/cms/create_a_case/cms_create_a_new_case_comps"
require "components/cms/create_a_case/cms_create_a_new_case_check_answers_comps"
require "components/cms/case/cms_single_case_nav_comps"
require "components/cms/case/cms_single_case_case_details_case_summary_check_answers_comps"
require "components/cms/case/cms_single_case_case_details_case_summary_comps"
require "components/cms/case/cms_single_case_case_details_comps"
require "components/cms/case/cms_single_case_messages_comps"
require "components/cms/case/task_list/evaluation/add_evaluator/cms_eval_add_evaluator_details_comps"
require "components/cms/case/task_list/evaluation/add_evaluator/cms_eval_add_evaluators_comps"
require "components/cms/case/task_list/evaluation/school_view/cms_eval_school_approved_comps"
require "components/cms/case/task_list/evaluation/school_view/cms_eval_school_download_docs_comps"
require "components/cms/case/task_list/evaluation/school_view/cms_eval_school_task_list_comps"
require "components/cms/case/task_list/evaluation/school_view/cms_eval_school_upload_eval_scoring_comps"
require "components/cms/case/task_list/evaluation/cms_eval_email_evaluators_comps"
require "components/cms/case/task_list/evaluation/cms_eval_review_evaluations_comps"
require "components/cms/case/task_list/evaluation/cms_eval_set_due_date_comps"
require "components/cms/case/task_list/cms_task_list_comps"
require "components/cms/case/task_list/evaluation/cms_eval_upload_documents_comps"

module SharedCmsComps
  # Pre Flow pages
  def cms_login_page_comps = @cms_login_page_comps ||= CmsLoginPageComps.new

  # My Cases
  def cms_mycases_page_comps = @cms_mycases_page_comps ||= CmsMyCasesPageComps.new
  def cms_find_a_case_page_comps = @cms_find_a_case_page_comps ||= CmsFindACasePageComps.new
  def cms_notifications_page_comps = @cms_notifications_page_comps ||= CmsNotificationsPageComps.new
  def cms_search_results_page_comps = @cms_search_results_page_comps ||= CmsSearchResultsPageComps.new

  # Single Case Actions
  def cms_single_case_view_page_comps = @cms_single_case_view_page_comps ||= CmsSingleCaseViewPageComps.new
  def cms_single_case_resolve_case_page_comps = @cms_single_case_resolve_case_page_comps ||= CmsSingleCaseResolveCasePageComps.new
  def cms_single_case_assign_to_case_worker_comps = @cms_single_case_assign_to_case_worker_comps ||= CmsSingleCaseAssignToCaseWorkerComps.new
  def cms_single_case_actions_comps = @cms_single_case_actions_comps ||= CmsSingleCaseActionsComps.new
  def cms_single_case_nav_comps = @cms_single_case_nav_comps ||= CmsSingleCaseNavComps.new

  # Single Case Actions - Case Details
  def cms_single_case_case_details_comps = @cms_single_case_case_details_comps ||= CmsSingleCaseCaseDetailsComps.new
  def cms_single_case_case_details_case_summary_comps = @cms_single_case_case_details_case_summary_comps ||= CmsSingleCaseCaseDetailsCaseSummaryComps.new
  def cms_single_case_case_details_case_summary_check_answers_comps = @cms_single_case_case_details_case_summary_check_answers_comps ||= CmsSingleCaseCaseDetailsCaseSummaryCheckAnswersComps.new
  def cms_single_case_messages_comps = @cms_single_case_messages_comps ||= CmsSingleCaseMessagesComps.new

  # Single Case Actions - Evaluation
  def cms_eval_add_evaluator_details_comps = @cms_eval_add_evaluator_details_comps ||= CmsEvalAddEvaluatorDetailsComps.new
  def cms_eval_add_evaluators_comps = @cms_eval_add_evaluators_comps ||= CmsEvalAddEvaluatorsComps.new
  def cms_eval_school_approved_comps = @cms_eval_school_approved_comps ||= CmsEvalSchoolApprovedComps.new
  def cms_eval_school_download_docs_comps = @cms_eval_school_download_docs_comps ||= CmsEvalSchoolDownloadDocsComps.new
  def cms_eval_school_task_list_comps = @cms_eval_school_task_list_comps ||= CmsEvalSchoolTaskListComps.new
  def cms_eval_school_upload_eval_scoring_comps = @cms_eval_school_upload_eval_scoring_comps ||= CmsEvalSchoolUploadEvalScoringComps.new
  def cms_eval_email_evaluators_comps = @cms_eval_email_evaluators_comps ||= CmsEvalEmailEvaluatorsComps.new
  def cms_eval_review_evaluations_comps = @cms_eval_review_evaluations_comps ||= CmsEvalReviewEvaluationsComps.new
  def cms_eval_set_due_date_comps = @cms_eval_set_due_date_comps ||= CmsEvalSetDueDateComps.new
  def cms_task_list_comps = @cms_task_list_comps ||= CmsTaskListComps.new
  def cms_eval_upload_documents_comps = @cms_eval_upload_documents_comps ||= CmsEvalUploadDocumentsComps.new

  # Navigation
  def cms_top_nav_comps = @cms_top_nav_comps ||= CmsTopNavComps.new

  # Create Case Actions
  def cms_create_a_new_case_comps = @cms_create_a_new_case_comps ||= CmsCreateANewCaseComps.new
  def cms_create_a_new_case_check_answers_comps = @cms_create_a_new_case_check_answers_comps ||= CmsCreateANewCaseCheckAnswersComps.new
end
