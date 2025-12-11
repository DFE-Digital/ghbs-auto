# frozen_string_literal: true

require "pages/cms/cms_base_page"
require "components/cms/find_a_case/cms_find_a_case_page_comps"
require "components/cms/find_a_case/cms_search_results_page_comps"
require "components/cms/case/cms_single_case_view_page_comps"
require "helpers/validation_helpers"

class CmsFindACaseMethods < CmsBasePage
  include ValidationHelpers
  def search_for_case(term)
    # Search the term
    cms_find_a_case_page_comps.input_search_case_info.set(term)
    case_state.search_term = term
    cms_find_a_case_page_comps.button_search.click

    # confirm the page load
    expect(page).to have_current_path(%r{/cases/find-a-case}, url: true, wait: 10)
    wait_for_heading_includes(cms_notifications_page_comps.text_page_heading, "Search results", timeout: 5)
  end

  def open_returned_result_with_case_number(term)
    # Click on the case number
    cms_search_results_page_comps.link_case_number(term).click

    # confirm the page load
    expect(page).to have_current_path(%r{/onboarding_cases/}, url: true, wait: 10)
    expect(cms_single_case_view_page_comps.text_page_heading_case_number.text).to include(term)
  end

  def open_first_active_status_result_with_case_number_for_current_user
    begin
      # Try Open — wait until at least 1 link exists
      links = cms_search_results_page_comps.links_case_number_with_open_status(minimum: 1)
      status = "Open"
    rescue Capybara::ExpectationNotMet
      begin
        # Fallback: try On Hold — wait until at least 1 link exists
        links = cms_search_results_page_comps.links_case_number_with_on_hold_status(minimum: 1)
        status = "On Hold"
      rescue Capybara::ExpectationNotMet
        raise "AUTO ERROR MESSAGE: No 'Open' or 'On Hold' results found"
      end
    end

    link = links.first
    case_number = link.text.strip.squeeze(" ")
    link.click

    expect(page).to have_current_path(%r{/onboarding_cases/}, url: true, wait: 10)
    expect(cms_single_case_view_page_comps.text_page_heading_case_number.text)
      .to include(case_number)

    puts "[INFO] Opened #{status} case #{case_number}"
  end

  def set_filter_by_status(option)
    # cms_search_results_page_comps.button_clear_filter.click - currently this takes the user back to the search screen instead of clearing. TBC defect.
    cms_search_results_page_comps.dropdown_filer_by_status(option).click
    cms_search_results_page_comps.button_apply_filter.click
  end
end
