# frozen_string_literal: true

require "pages/cms/cms_base_page"
require "helpers/validation_helpers"
require "helpers/upload_file_helpers"
require "components/cms/case/cms_single_case_actions_comps"
require "components/cms/case/cms_single_case_view_page_comps"
require "components/cms/case/actions/cms_case_actions_log_contact_with_school_comps"
require "components/cms/case/actions/cms_case_actions_resolve_case_comps"
require "components/cms/case/actions/cms_case_actions_reopen_case_comps"

class CmsCaseStatesMethods < CmsBasePage
  include ValidationHelpers
  include UploadFileHelpers

  def switch_case_states(action, expected_status)
    # Billing address
    case action
    when "Create a new case"
      # 1. Create new case - New, no action needed as prev steps should have us in this state.
    when "Log contact with school"
      # 2. Actions - Log contact with school - On Hold
      # Select "log contact with school" from the actions list
      cms_single_case_actions_comps.link_log_contact_with_school.click
      wait_for_element_to_include(cms_case_actions_log_contact_with_school_comps.text_page_heading, "Contact with school", timeout: 5)

      # Set Type of contract
      cms_case_actions_log_contact_with_school_comps.radio_phone_call.click

      # Set Contact Details
      cms_case_actions_log_contact_with_school_comps.input_contact_details.set("Auto Test ES-1113")

      # Save interaction
      cms_case_actions_log_contact_with_school_comps.button_save.click

      # Validate we have returned to the case page and the notice is present
      wait_for_element_to_include(cms_single_case_view_page_comps.text_page_heading, case_state.case_organisation_name, timeout: 5)
      wait_for_element_to_include(cms_single_case_view_page_comps.text_flash_notice_content, "Phone call added to case", timeout: 5)

    when "Reopen case from On Hold"
      # 3. Actions - Reopen case - Open
      # Confirm were still within the case
      wait_for_element_to_include(cms_single_case_view_page_comps.text_page_heading, case_state.case_organisation_name, timeout: 5)

      # Select the reopen case action
      cms_single_case_actions_comps.link_reopen_case.click

      # confirm the notice
      wait_for_element_to_include(cms_single_case_view_page_comps.text_flash_notice_content, "Case reopened successfully", timeout: 5)

    when "Reopen case from resolved"
      # 5. Actions - Reopen case - Open

      # Confirm were still within the case
      wait_for_element_to_include(cms_single_case_view_page_comps.text_page_heading, case_state.case_organisation_name, timeout: 5)

      # Select the reopen case action
      cms_single_case_actions_comps.link_reopen_case.click

      # Confirm you are sure you want to reopen the case
      wait_for_element_to_include(cms_case_actions_reopen_case_comps.text_page_heading, "Are you sure you want to reopen this case?", timeout: 5)
      cms_case_actions_reopen_case_comps.button_reopen_the_case.click

      # confirm the notice
      wait_for_element_to_include(cms_single_case_view_page_comps.text_flash_notice_content, "Case reopened successfully", timeout: 5)

    when "Resolve case"
      # 4. Actions - Resolve Case - Resolved
      # Confirm were still within the case
      wait_for_element_to_include(cms_single_case_view_page_comps.text_page_heading, case_state.case_organisation_name, timeout: 5)

      # Select the reopen case action
      cms_single_case_actions_comps.link_resolve_case.click

      # Complete the resolve case form
      wait_for_element_to_include(cms_case_actions_resolve_case_comps.text_page_heading, "Resolve case", timeout: 5)
      cms_case_actions_resolve_case_comps.input_notes.set("Auto Test ES-1113")
      cms_case_actions_resolve_case_comps.button_save_and_close_case.click

      # confirm the notice
      wait_for_element_to_include(cms_single_case_view_page_comps.text_flash_notice_content, "Case resolved successfully", timeout: 5)

    when "Reject case"
      # 6. Actions - Reject case - Closed
    else
      raise ArgumentError, "Unknown case action: #{action}, expected direction to trigger a case state change"
    end

    # Validate the expected_status is = to expected
    wait_for_element_to_include(cms_single_case_view_page_comps.text_case_status_badge, expected_status, timeout: 5)
  end
end
