# frozen_string_literal: true

require "components/cms/cms_login_page_comps"
require "components/cms/cms_mycases_page_comps"
require "components/cms/cms_top_nav_comps"
require "components/cms/cms_find_a_case_page_comps"
require "components/cms/cms_notifications_page_comps"
require "components/cms/cms_search_results_page_comps"
require "components/cms/cms_individual_case_view_page_steps"

module SharedCmsComps
  # Pre Flow pages
  def cms_login_page_comps = @cms_login_page_comps ||= CmsLoginPageComps.new

  # My Cases
  def cms_mycases_page_comps = @cms_mycases_page_comps ||= CmsMyCasesPageComps.new
  def cms_find_a_case_page_comps = @cms_find_a_case_page_comps ||= CmsFindACasePageComps.new
  def cms_notifications_page_comps = @cms_notifications_page_comps ||= CmsNotificationsPageComps.new
  def cms_search_results_page_comps = @cms_search_results_page_comps ||= CmsSearchResultsPageComps.new
  def cms_individual_case_view_page_steps = @cms_individual_case_view_page_steps ||= CmsIndividualCasePageComps.new

  # Navigation
  def cms_top_nav_comps = @cms_top_nav_comps ||= CmsTopNavComps.new

end
