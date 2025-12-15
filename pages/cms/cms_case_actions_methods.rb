# frozen_string_literal: true

require "pages/cms/cms_base_page"
require "components/cms/case/cms_single_case_actions_comps"
require "components/cms/case/cms_single_case_resolve_case_page_comps"
require "components/cms/case/cms_single_case_view_page_comps"
require "components/cms/find_a_case/cms_search_results_page_comps"
require "components/cms/case/cms_single_case_nav_comps"
require "components/cms/case/cms_single_case_messages_comps"
require "pages/cms/cms_find_a_case_methods"
require "pages/cms/cms_top_nav_methods"
class CmsCaseActionsMethods < CmsBasePage
  def complete_resolve_case_flow
    case_status = cms_single_case_view_page_comps.text_case_status_badge.text.strip.squeeze(" ")

    if case_status == "On Hold"
      # sometimes the case is in an "On Hold" state, to close the case we first need to reopen it!
      _reopen_current_on_hold_case
    end

    # navigate to the resolve case screen
    cms_single_case_actions_comps.link_resolve_case.click

    # confirm the page load
    expect(page).to have_current_path(%r{/cases}, url: true, wait: 10)
    expect(cms_single_case_resolve_case_page_comps.text_page_heading.text).to include("Resolve case")

    # enter text in to the notes field and complete the resolution
    cms_single_case_resolve_case_page_comps.input_notes.set("This is an auto test case resolution")
    cms_single_case_resolve_case_page_comps.button_save_and_close_case.click

    # confirm the resolution has been completed.
    expect(page).to have_current_path(%r{/support/cases/}, url: true, wait: 10)
    expect(cms_single_case_view_page_comps.text_flash_notice_content.text).to include("Case resolved successfully")
  end

  def complete_and_close_all_open_cases
    # First goal: get all "New" cases in to an "on hold" state so we can resolve them!
    world.cms_find_a_case_methods.set_filter_by_status("New")
    starting_count_of_new_cases = cms_search_results_page_comps.text_number_of_results.text
    rolling_count_of_cases = 0
    puts "[Info] Total #{starting_count_of_new_cases} 'New' cases identified"

    loop do
      # Search for "New" cases
      count_of_new_cases = cms_search_results_page_comps.text_number_of_results.text
      count_of_new_cases = count_of_new_cases.split("cases found containing").first.strip.to_i
      break if count_of_new_cases.zero?

      # Select and open the first case
      case_number = cms_search_results_page_comps.link_first_case_number.text
      cms_search_results_page_comps.link_first_case_number.click
      expect(page).to have_current_path(%r{/support/cases/}, url: true, wait: 10)
      expect(cms_single_case_view_page_comps.text_page_heading_case_number.text).to include(case_number)

      # Send an email for that case
      cms_single_case_nav_comps.link_messages.click
      expect(cms_single_case_messages_comps.text_messages_sub_heading.text).to include("Messages")

      cms_single_case_messages_comps.link_create_a_new_message_thread.click
      cms_single_case_messages_comps.button_create_using_a_sig_template.click
      cms_single_case_messages_comps.button_send_message.click
      # Doing this puts the message in to a new state of "On Hold" which we can then close from.
      # Run the search again for our target org
      world.cms_top_nav_methods.nav_to_find_a_case_screen
      world.cms_find_a_case_methods.search_for_case(case_state.search_term)
      world.cms_find_a_case_methods.set_filter_by_status("New")
      rolling_count_of_cases += 1
      puts "[Info] #{rolling_count_of_cases} / #{starting_count_of_new_cases} 'New' cases processed"
      sleep(10) # Artificial wait to stop Azure blocking the request for too much use. TBC investigation from dev team.
    end

    # Now all the cases are in a resolvable state, we can start processing them.
    puts "[Info] All 'New' records processed. No more found."

    # Now we have all the records in a state we can do something about!
    # First on the list is any "On Hold" cases!
    _resolve_case("On Hold")

    # Next up is "Open" cases!
    _resolve_case("Open")
  end

private

  def _reopen_current_on_hold_case
    attempts = 0
    max_attempts = 3

    begin
      attempts += 1
      puts "Attempt ##{attempts}"

      cms_single_case_actions_comps.link_reopen_case.click
      expect(page).to have_current_path(%r{/support/cases/}, url: true, wait: 10)
      expect(cms_single_case_view_page_comps.text_flash_notice_content.text).to include("Case reopened successfully")
    rescue StandardError => e
      puts "Attempt ##{attempts} failed: #{e.message}"
      retry if attempts < max_attempts
      raise "Failed after #{attempts} attempts"
    end
  end

  def _resolve_case(status_type)
    puts "[Info] Starting processing of '#{status_type}' cases"

    # Next up is "status_type" cases!
    world.cms_top_nav_methods.nav_to_find_a_case_screen
    world.cms_find_a_case_methods.search_for_case(case_state.search_term)
    world.cms_find_a_case_methods.set_filter_by_status(status_type)
    sleep(1) # allows time for the field to change number of results to match the filter
    starting_count_of_new_cases = cms_search_results_page_comps.text_number_of_results.text
    rolling_count_of_cases = 0
    puts "[Info] Total #{starting_count_of_new_cases} of '#{status_type}' cases identified"

    loop do
      # Search for "status_type" cases
      count_of_new_cases = cms_search_results_page_comps.text_number_of_results.text
      count_of_new_cases = count_of_new_cases.split("cases found containing").first.strip.to_i
      break if count_of_new_cases.zero?

      # Select and open the first case
      case_number = cms_search_results_page_comps.link_first_case_number.text
      cms_search_results_page_comps.link_first_case_number.click
      expect(page).to have_current_path(%r{/support/cases/}, url: true, wait: 10)
      expect(cms_single_case_view_page_comps.text_page_heading_case_number.text).to include(case_number)

      # Close off the "status_type" Case
      complete_resolve_case_flow

      # Run the search again for our target org
      world.cms_top_nav_methods.nav_to_find_a_case_screen
      world.cms_find_a_case_methods.search_for_case(case_state.search_term)
      world.cms_find_a_case_methods.set_filter_by_status(status_type)
      rolling_count_of_cases += 1
      puts "[Info] #{rolling_count_of_cases} / #{starting_count_of_new_cases} with a status of '#{status_type}' have been processed"
      sleep(20) # Artificial wait to stop Azure blocking the request for too much use. TBC investigation from dev team.
    end

    puts "[Info] All '#{status_type}' records processed. No more found."
  end
end
