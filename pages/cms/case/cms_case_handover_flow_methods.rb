# frozen_string_literal: true

require "pages/cms/cms_base_page"
require "components/cms/case/cms_single_case_nav_comps"
require "components/cms/case/task_list/cms_task_list_comps"
require "components/cms/case/task_list/handover/add_recipients/cms_handover_add_contract_recipient_details_comps"
require "components/cms/case/task_list/handover/add_recipients/cms_handover_add_contract_recipients_comps"
require "components/cms/case/task_list/handover/cms_handover_share_contract_comps"
require "components/cms/case/task_list/handover/cms_handover_upload_contract_comps"
require "helpers/validation_helpers"
require "helpers/upload_file_helpers"

class CmsCaseHandoverFlowMethods < CmsBasePage
  include ValidationHelpers
  include UploadFileHelpers
  def complete_initial_handover_setup_proc_ops_side
    # At this point we assume the user has already set the case to a level 4 and has the "Task list" tab available to them
    cms_single_case_nav_comps.link_task_list.click
    expect(page).to have_current_path(%r{/support/cases/}, url: true, wait: 10)
    expect(cms_task_list_comps.text_section_heading.text).to include("Procurement task list")
    expect(cms_task_list_comps.text_handover_heading.text).to include("Share contract and handover document")

    complete_add_contract_recipients
    complete_upload_contract
    complete_share_contract_and_handover_doc
  end

  def complete_add_contract_recipients
    # Handover State Check
    expect(cms_task_list_comps.text_add_contract_recipients_status.text).to include("To do")
    expect(cms_task_list_comps.text_upload_contract_and_handover_document_status.text).to include("To do")
    expect(cms_task_list_comps.text_inactive_share_contract_and_handover_document_status.text).to include("Cannot start")
    expect(cms_task_list_comps.text_inactive_download_contract_and_handover_document_status.text).to include("Cannot start")

    # Open the "Add contract recipients" page
    cms_task_list_comps.link_add_contract_recipients.click
    wait_for_heading_includes(cms_handover_add_contract_recipients_comps.text_page_heading, "Contract Recipients", timeout: 5)

    # Complete the "Add" process to add a new recipient
    cms_handover_add_contract_recipients_comps.button_add.click
    wait_for_heading_includes(cms_handover_add_contract_recipient_details_comps.text_page_heading, "Add contract recipient details", timeout: 5)

    user_first_name = "AutoTestHandFN-#{Time.now.strftime('%S-%M-%H-%m-%d-%Y')}"
    user_last_name = "AutoTesthandLN"
    cms_handover_add_contract_recipient_details_comps.input_first_name.set(user_first_name)
    cms_handover_add_contract_recipient_details_comps.input_last_name.set(user_last_name)
    case_state.case_handover_1_email = SECRETS["proc_ops_cms_username"]
    cms_handover_add_contract_recipient_details_comps.input_email_address.set(case_state.case_handover_1_email)

    cms_handover_add_contract_recipient_details_comps.button_save_changes.click
    wait_for_heading_includes(cms_handover_add_contract_recipients_comps.text_page_heading, "Contract Recipients", timeout: 5)

    # Confirm our user has been added
    cms_handover_add_contract_recipients_comps.text_recipient_email_address(case_state.case_handover_1_email)
    cms_handover_add_contract_recipients_comps.text_recipient_name("#{user_first_name} #{user_last_name}")

    # Return to the main menu
    cms_handover_add_contract_recipients_comps.button_back.click
    expect(page).to have_current_path(%r{/support/cases/}, url: true, wait: 10)
    expect(cms_task_list_comps.text_section_heading.text).to include("Procurement task list")
    expect(cms_task_list_comps.text_handover_heading.text).to include("Share contract and handover document")
    expect(cms_task_list_comps.text_add_contract_recipients_status.text).to include("Complete")
  end

  def complete_upload_contract
    # Handover State Check
    expect(cms_task_list_comps.text_add_contract_recipients_status.text).to include("Complete")
    expect(cms_task_list_comps.text_upload_contract_and_handover_document_status.text).to include("To do")
    expect(cms_task_list_comps.text_inactive_share_contract_and_handover_document_status.text).to include("Cannot start")
    expect(cms_task_list_comps.text_inactive_download_contract_and_handover_document_status.text).to include("Cannot start")

    # Open the "Upload contract and handover document" page
    cms_task_list_comps.link_upload_contract_and_handover_document.click
    wait_for_heading_includes(cms_handover_upload_contract_comps.text_page_heading, "Upload handover pack", timeout: 5)

    # Upload the test file via Dropzone
    upload_file_via_dropzone("resources/test_data/handover_doc.txt", input_selector: 'input[type="file"].dz-hidden-input')
    case_state.case_proc_ops_handover_uploaded_file_name_1 = "handover_doc.txt"

    # Validate the document is uploaded
    wait_for_heading_includes(cms_handover_upload_contract_comps.text_uploaded_file_name("handover_doc.txt"), "handover_doc.txt", timeout: 5)

    # Confirm all docs are uploaded
    cms_handover_upload_contract_comps.radio_yes.click

    # Return to the main menu
    cms_handover_upload_contract_comps.button_continue.click
    expect(page).to have_current_path(%r{/support/cases/}, url: true, wait: 5)
    expect(cms_task_list_comps.text_section_heading.text).to include("Procurement task list")
    expect(cms_task_list_comps.text_upload_contract_and_handover_document_status.text).to include("Complete")
  end

  def complete_share_contract_and_handover_doc
    # Handover State Check
    expect(cms_task_list_comps.text_add_contract_recipients_status.text).to include("Complete")
    expect(cms_task_list_comps.text_upload_contract_and_handover_document_status.text).to include("Complete")
    expect(cms_task_list_comps.text_share_contract_and_handover_document_status.text).to include("To do")
    expect(cms_task_list_comps.text_inactive_download_contract_and_handover_document_status.text).to include("Cannot start")

    # Open the "Share contract and handover document" page
    cms_task_list_comps.link_share_contract_and_handover_document.click
    wait_for_heading_includes(cms_handover_share_contract_comps.text_page_heading, "Share handover pack", timeout: 5)

    # Validate handover recipients email addresses are visible in the "sharing with" section
    cms_handover_share_contract_comps.text_sharing_with_email_list(case_state.case_handover_1_email)

    # Validate uploaded attachments are referenced in the "Documents" section
    cms_handover_share_contract_comps.text_docs_uploaded_list(case_state.case_proc_ops_handover_uploaded_file_name_1)

    # Retrieve the "unique-case-specific-link" from the email template
    case_state.case_handover_case_specific_link = cms_handover_share_contract_comps.unique_case_specific_link_href

    # Send the email. / Return to the main menu
    cms_handover_share_contract_comps.button_send_email_and_continue.click
    expect(page).to have_current_path(%r{/support/cases/}, url: true, wait: 10)
    expect(cms_task_list_comps.text_section_heading.text).to include("Procurement task list")

    # Handover State Check
    expect(cms_task_list_comps.text_add_contract_recipients_status.text).to include("Complete")
    expect(cms_task_list_comps.text_upload_contract_and_handover_document_status.text).to include("Complete")
    expect(cms_task_list_comps.text_share_contract_and_handover_document_status.text).to include("Complete")
    expect(cms_task_list_comps.text_inactive_download_contract_and_handover_document_status.text).to include("Cannot start")
  end

  def validate_download_contract_handover_pre_school_completion
    # Return to the CMS home page
    visit SECRETS["dev_proc_ops_cms_homepage_url"]
    expect(page).to have_current_path(%r{/support#my-cases}, url: true, wait: 10)
    expect(cms_mycases_page_comps.text_page_heading.text).to include("My cases")

    # Re-open our case and nav to task list
    world.cms_top_nav_methods.nav_to_find_a_case_screen
    world.cms_find_a_case_methods.search_for_case(case_state.case_number)
    world.cms_find_a_case_methods.open_returned_result_with_case_number(case_state.case_number)
    cms_single_case_nav_comps.link_task_list.click
    expect(page).to have_current_path(%r{/support/cases/}, url: true, wait: 10)
    expect(cms_task_list_comps.text_section_heading.text).to include("Procurement task list")

    # Handover State Check
    expect(cms_task_list_comps.text_add_contract_recipients_status.text).to include("Complete")
    expect(cms_task_list_comps.text_upload_contract_and_handover_document_status.text).to include("Complete")
    expect(cms_task_list_comps.text_share_contract_and_handover_document_status.text).to include("Complete")
    expect(cms_task_list_comps.text_inactive_download_contract_and_handover_document_status.text).to include("Complete")
  end
end
