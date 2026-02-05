# frozen_string_literal: true

require "pages/cms/cms_base_page"
require "components/cms/find_a_case/cms_find_a_case_page_comps"
require "components/cms/find_a_case/cms_search_results_page_comps"
require "components/cms/case/cms_single_case_view_page_comps"
require "components/cms/case/cms_single_case_nav_comps"
require "components/cms/case/cms_single_case_school_details_comps"
require "components/cms/case/cms_single_case_onboarding_summary_comps"
require "helpers/validation_helpers"

class CmsFindACaseMethods < CmsBasePage
  include ValidationHelpers
  def search_for_case(term)
    # This calls the resolve_term allowing us to swap out for stored secrets when needed.
    term = resolve_term(term)

    # Search the term
    cms_find_a_case_page_comps.input_search_case_info.set(term)
    case_state.search_term = term
    cms_find_a_case_page_comps.button_search.click

    # confirm the page load
    expect(page).to have_current_path(%r{/cases/find-a-case}, url: true, wait: 10)
    wait_for_element_to_include(cms_notifications_page_comps.text_page_heading, "Search results", timeout: 5)
  end

  def open_returned_result_with_case_number(term)
    # Click on the case number
    cms_search_results_page_comps.link_case_number(term).click

    # confirm the page load
    wait_for_element_to_include(cms_single_case_view_page_comps.text_page_heading_case_number, term, timeout: 5)
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
    expect(cms_single_case_view_page_comps.text_page_heading_case_number.text).to include(case_number)

    puts "[INFO] Opened #{status} case #{case_number}"
  end

  def set_filter_by_status(option)
    # cms_search_results_page_comps.button_clear_filter.click - currently this takes the user back to the search screen instead of clearing. TBC defect.
    cms_search_results_page_comps.dropdown_filer_by_status(option).click
    cms_search_results_page_comps.button_apply_filter.click
  end

  def validate_results_for_search_term(search_term_type)
    # confirm the page load
    expect(page).to have_current_path(%r{/cases/find-a-case}, url: true, wait: 10)
    wait_for_element_to_include(cms_notifications_page_comps.text_page_heading, "Search results", timeout: 5)

    # Validate content based on search term
    case search_term_type
    when "case id"
      wait_for_element_to_include(cms_search_results_page_comps.link_org_based_on_case_number("000880"), "Finchley Catholic High School", timeout: 5)

    when "contact email"
      # Select the top result from the list
      case_number = cms_search_results_page_comps.link_first_case_number.text
      cms_search_results_page_comps.link_first_case_number.click
      wait_for_element_to_include(cms_single_case_view_page_comps.text_page_heading_case_number, case_number, timeout: 5)

      # open and validate the school details contain our expected user
      cms_single_case_nav_comps.link_school_details.click
      wait_for_element_to_include(cms_single_case_school_details_comps.text_section_heading, "School details", timeout: 5)
      # expect(cms_single_case_school_details_comps.text_contact_email.text.downcase).to include(SECRETS["test_user_1"])
      wait_for_element_to_include(cms_single_case_school_details_comps.text_contact_email, SECRETS["test_user_1"], timeout: 5, downcase: true)

    when "organisation name"
      # Select the top result from the list
      case_number = cms_search_results_page_comps.link_first_case_number.text
      cms_search_results_page_comps.link_first_case_number.click
      wait_for_element_to_include(cms_single_case_view_page_comps.text_page_heading_case_number, case_number, timeout: 5)

      # open and validate the school details contain our org name
      cms_single_case_nav_comps.link_school_details.click
      wait_for_element_to_include(cms_single_case_school_details_comps.text_section_heading, "School details", timeout: 5)
      wait_for_element_to_include(cms_single_case_school_details_comps.text_organisation_name, "Hazelwick School", timeout: 5)

    when "establishment group"
      # Validate the returned list of search results all match
      list_of_orgs = cms_search_results_page_comps.link_all_orgs_in_list

      puts "Found #{list_of_orgs.size} result rows"

      list_of_orgs.each_with_index do |org, index|
        text = org.text.strip
        puts "Row #{index + 1}: #{text}"

        expect(text).to include("ABBEY ACADEMIES TRUST"), "Row #{index + 1} did not include search term"
      end

    when "URN"
      # Validate the returned list of search results all match
      list_of_orgs = cms_search_results_page_comps.link_all_orgs_in_list

      puts "Found #{list_of_orgs.size} result rows"

      list_of_orgs.each_with_index do |org, index|
        text = org.text.strip
        puts "Row #{index + 1}: #{text}"

        expect(text).to include("Bourne Abbey Church of England Primary Academy"), "Row #{index + 1} did not include search term"
      end

    when "MPRN"
      # Select the top result from the list
      case_number = cms_search_results_page_comps.link_first_case_number.text
      cms_search_results_page_comps.link_first_case_number.click
      wait_for_element_to_include(cms_single_case_view_page_comps.text_page_heading_case_number, case_number, timeout: 5)

      # open and validate the school details contain our MPRN
      cms_single_case_nav_comps.link_onboarding_summary.click
      wait_for_element_to_include(cms_single_case_onboarding_summary_comps.text_section_heading, "Onboarding summary", timeout: 5)
      wait_for_element_to_include(cms_single_case_onboarding_summary_comps.text_gas_meter_point_reference_number_1, "846175353591", timeout: 5)

    when "MPAN"
      # Select the top result from the list
      case_number = cms_search_results_page_comps.link_first_case_number.text
      cms_search_results_page_comps.link_first_case_number.click
      wait_for_element_to_include(cms_single_case_view_page_comps.text_page_heading_case_number, case_number, timeout: 5)

      # open and validate the school details contain our MPAN
      cms_single_case_nav_comps.link_onboarding_summary.click
      wait_for_element_to_include(cms_single_case_onboarding_summary_comps.text_section_heading, "Onboarding summary", timeout: 5)
      wait_for_element_to_include(cms_single_case_onboarding_summary_comps.text_electric_mpan_number_1, "7084082061701", timeout: 5)

    when "case owner"
      # Select the top result from the list
      case_number = cms_search_results_page_comps.link_first_case_number.text
      cms_search_results_page_comps.link_first_case_number.click
      wait_for_element_to_include(cms_single_case_view_page_comps.text_page_heading_case_number, case_number, timeout: 5)

      # open and validate the case owner is as expected
      cms_single_case_nav_comps.link_school_details.click
      wait_for_element_to_include(cms_single_case_school_details_comps.text_section_heading, "School details", timeout: 5)
      wait_for_element_to_include(cms_single_case_view_page_comps.text_page_heading_case_owner, "Case owner: Auto 1 Test User 1", timeout: 5)
    else
      raise ArgumentError, "search_term_type '#{search_term_type}' hasn't been implemented yet."
    end
  end

private

  def resolve_term(term)
    return term unless term.is_a?(String)

    SECRETS.fetch(term, term)
  end
end
