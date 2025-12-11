# frozen_string_literal: true

require "components/cms/cms_login_page_comps"
require "components/cms/cms_mycases_page_comps"
require "components/cms/cms_top_nav_comps"
require "components/cms/find_a_case/cms_find_a_case_page_comps"
require "components/cms/cms_notifications_page_comps"
require "components/cms/find_a_case/cms_search_results_page_comps"
require "components/cms/case/cms_single_case_view_page_comps"
require "components/cms/case/cms_single_case_resolve_case_page_comps"
require "components/cms/case/cms_single_case_actions_comps"
require "components/cms/create_a_case/cms_create_a_new_case_comps"
require "components/cms/create_a_case/cms_create_a_new_case_check_answers_comps"
require "components/cms/case/cms_single_case_nav_comps"
require "components/cms/case/cms_single_case_case_details_case_summary_check_answers_comps"
require "components/cms/case/cms_single_case_case_details_case_summary_comps"
require "components/cms/case/cms_single_case_case_details_comps"
require "components/cms/case/cms_single_case_messages_comps"

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
  def cms_single_case_actions_comps = @cms_single_case_actions_comps ||= CmsSingleCaseActionsComps.new
  def cms_single_case_nav_comps = @cms_single_case_nav_comps ||= CmsSingleCaseNavComps.new

  # Single Case Actions - Case Details
  def cms_single_case_case_details_comps = @cms_single_case_case_details_comps ||= CmsSingleCaseCaseDetailsComps.new
  def cms_single_case_case_details_case_summary_comps = @cms_single_case_case_details_case_summary_comps ||= CmsSingleCaseCaseDetailsCaseSummaryComps.new
  def cms_single_case_case_details_case_summary_check_answers_comps = @cms_single_case_case_details_case_summary_check_answers_comps ||= CmsSingleCaseCaseDetailsCaseSummaryCheckAnswersComps.new
  def cms_single_case_messages_comps = @cms_single_case_messages_comps ||= CmsSingleCaseMessagesComps.new

  # Navigation
  def cms_top_nav_comps = @cms_top_nav_comps ||= CmsTopNavComps.new

  # Create Case Actions
  def cms_create_a_new_case_comps = @cms_create_a_new_case_comps ||= CmsCreateANewCaseComps.new
  def cms_create_a_new_case_check_answers_comps = @cms_create_a_new_case_check_answers_comps ||= CmsCreateANewCaseCheckAnswersComps.new
end
