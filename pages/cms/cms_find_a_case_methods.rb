# frozen_string_literal: true

require "pages/cms/cms_base_page"
require "components/cms/cms_find_a_case_page_comps"
require "components/cms/cms_search_results_page_comps"
require "components/cms/cms_individual_case_view_page_steps"

class CmsFindACaseMethods < CmsBasePage
  def search_for_case(term)
    # Search the term
    cms_find_a_case_page_comps.input_search_case_info.set(term)
    cms_find_a_case_page_comps.button_search.click

    # confirm the page load
    expect(page).to have_current_path(%r{/cases/find-a-case}, url: true, wait: 10)
    expect(cms_notifications_page_comps.text_page_heading.text).to include("Search results")
  end

  def open_returned_result_with_case_number(term)
    # Click on the case number
    cms_search_results_page_comps.link_case_number(term).click

    # confirm the page load
    expect(page).to have_current_path(%r{/onboarding_cases/}, url: true, wait: 10)
    expect(cms_individual_case_view_page_steps.text_page_heading_case_number.text).to include(term)
  end
end
