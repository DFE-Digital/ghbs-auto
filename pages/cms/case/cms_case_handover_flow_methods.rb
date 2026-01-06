# frozen_string_literal: true

require "pages/cms/cms_base_page"
require "components/cms/case/cms_single_case_nav_comps"
require "components/cms/case/task_list/cms_task_list_comps"
require "components/cms/case/task_list/handover/add_recipients/cms_handover_add_contract_recipient_details_comps"
require "components/cms/case/task_list/handover/add_recipients/cms_handover_add_contract_recipients_comps"
require "components/cms/case/task_list/handover/school_view/cms_handover_download_contract_comps"
require "components/cms/case/task_list/handover/school_view/cms_handover_proc_task_list_comps"
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
    cms_handover_add_contract_recipients_comps.text_recipient_email_address(case_state.case_evaluator_1_email)
    cms_handover_add_contract_recipients_comps.text_recipient_name("#{user_first_name} #{user_last_name}")

    # Return to the main menu
    cms_handover_add_contract_recipients_comps.button_back.click
    expect(page).to have_current_path(%r{/support/cases/}, url: true, wait: 10)
    expect(cms_task_list_comps.text_section_heading.text).to include("Procurement task list")
    expect(cms_task_list_comps.text_handover_heading.text).to include("Share contract and handover document")
    expect(cms_task_list_comps.text_add_contract_recipients_status.text).to include("Complete")
  end

  def complete_upload_contract
    # TODO
  end

  def complete_share_contract_and_handover_doc
    # TODO
  end

  def validate_download_contract_handover_pre_school_completion
    # TODO
  end

end
