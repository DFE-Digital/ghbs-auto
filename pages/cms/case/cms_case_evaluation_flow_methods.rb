# frozen_string_literal: true

require "pages/cms/cms_base_page"
require "components/cms/case/cms_single_case_nav_comps"
require "components/cms/case/task_list/evaluation/cms_eval_task_list_comps"
require "components/cms/case/task_list/evaluation/add_evaluator/cms_eval_add_evaluators_comps"
require "components/cms/case/task_list/evaluation/add_evaluator/cms_eval_add_evaluator_details_comps"
require "components/cms/case/task_list/evaluation/cms_eval_set_due_date_comps"
require "components/cms/case/task_list/evaluation/cms_eval_upload_documents_comps"
require "components/cms/case/task_list/evaluation/cms_eval_email_evaluators_comps"
require "helpers/validation_helpers"
require "helpers/upload_file_helpers"

class CmsCaseEvaluationFlowMethods < CmsBasePage
  include ValidationHelpers
  include UploadFileHelpers
  def complete_initial_eval_setup_proc_ops_side
    # At this point we assume the user has already set the case to a level 4 and has the "Task list" tab available to them
    cms_single_case_nav_comps.link_task_list.click
    expect(page).to have_current_path(%r{/support/cases/}, url: true, wait: 10)
    expect(cms_eval_task_list_comps.text_section_heading.text).to include("Procurement task list")
    expect(cms_eval_task_list_comps.text_evaluation_heading.text).to include("Complete evaluation")

    complete_add_evaluators
    complete_set_due_date
    complete_upload_documents
    complete_email_evaluators
  end

  def complete_add_evaluators
    # Open the "Add evaluators" page
    cms_eval_task_list_comps.link_add_evaluators.click
    wait_for_heading_includes(cms_eval_add_evaluators_comps.text_page_heading, "Evaluators", timeout: 5)

    # Complete the "Add" process to add a new evaluator
    cms_eval_add_evaluators_comps.button_add.click
    wait_for_heading_includes(cms_eval_add_evaluator_details_comps.text_page_heading, "Add evaluator details", timeout: 5)

    user_first_name = "AutoTestEvalFN-#{Time.now.strftime('%S-%M-%H-%m-%d-%Y')}"
    user_last_name = "AutoTestEvalLN"
    cms_eval_add_evaluator_details_comps.input_first_name.set(user_first_name)
    cms_eval_add_evaluator_details_comps.input_last_name.set(user_last_name)
    case_state.case_evaluator_1_email = SECRETS["proc_ops_cms_username"]
    cms_eval_add_evaluator_details_comps.input_email_address.set(case_state.case_evaluator_1_email)

    cms_eval_add_evaluator_details_comps.button_save_changes.click
    wait_for_heading_includes(cms_eval_add_evaluators_comps.text_page_heading, "Evaluators", timeout: 5)

    # Confirm our user has been added
    cms_eval_add_evaluators_comps.text_evaluator_email_address(case_state.case_evaluator_1_email)
    cms_eval_add_evaluators_comps.text_evaluator_name("#{user_first_name} #{user_last_name}")

    # Return to the main menu
    cms_eval_add_evaluators_comps.button_back.click
    expect(page).to have_current_path(%r{/support/cases/}, url: true, wait: 10)
    expect(cms_eval_task_list_comps.text_section_heading.text).to include("Procurement task list")
    expect(cms_eval_task_list_comps.text_evaluation_heading.text).to include("Complete evaluation")
    expect(cms_eval_task_list_comps.text_add_evaluators_status.text).to include("Complete")
  end

  def complete_set_due_date
    # Open the "Set due date" page
    cms_eval_task_list_comps.link_set_due_date.click

    # Complete the "Set due date" process
    wait_for_heading_includes(cms_eval_set_due_date_comps.text_page_heading, "Set due date", timeout: 5)

    # get today's date + 60 days
    future_date = Date.today + 60

    # extract individual parts with leading zeros
    day   = sprintf("%02d", future_date.day)
    month = sprintf("%02d", future_date.month)
    year  = future_date.year.to_s

    # set each field on the page
    cms_eval_set_due_date_comps.input_day.set(day)
    cms_eval_set_due_date_comps.input_month.set(month)
    cms_eval_set_due_date_comps.input_year.set(year)

    # Add to case state
    case_state.case_evaluation_due_date = "#{day}-#{month}-#{year}"

    # Return to the main menu
    cms_eval_set_due_date_comps.button_continue.click
    expect(page).to have_current_path(%r{/support/cases/}, url: true, wait: 10)
    expect(cms_eval_task_list_comps.text_section_heading.text).to include("Procurement task list")
    expect(cms_eval_task_list_comps.text_set_due_date_status.text).to include("Complete")
  end

  def complete_upload_documents
    # Open the "Upload documents" page
    cms_eval_task_list_comps.link_upload_documents.click
    wait_for_heading_includes(cms_eval_upload_documents_comps.text_page_heading, "Upload documents", timeout: 5)

    # Upload the test file via Dropzone
    upload_file_via_dropzone("resources/test_data/evaluation_doc.txt", input_selector: 'input[type="file"].dz-hidden-input')
    case_state.case_uploaded_file_name_1 = "evaluation_doc.txt"

    # Validate the document is uploaded
    wait_for_heading_includes(cms_eval_upload_documents_comps.text_uploaded_file_name("evaluation_doc.txt"), "evaluation_doc.txt", timeout: 5)

    # Confirm all docs are uploaded
    cms_eval_upload_documents_comps.radio_yes.click

    # Return to the main menu
    cms_eval_upload_documents_comps.button_continue.click
    expect(page).to have_current_path(%r{/support/cases/}, url: true, wait: 5)
    expect(cms_eval_task_list_comps.text_section_heading.text).to include("Procurement task list")
    expect(cms_eval_task_list_comps.text_upload_documents_status.text).to include("Complete")
  end

  def complete_email_evaluators
    # Open the "Upload documents" page
    cms_eval_task_list_comps.link_email_evaluators.click
    wait_for_heading_includes(cms_eval_email_evaluators_comps.text_page_heading, "Email evaluators", timeout: 5)

    # Validate evaluators email addresses are visible in the "sharing with" section
    cms_eval_email_evaluators_comps.text_sharing_with_email_list(case_state.case_evaluator_1_email)

    # Validate uploaded attachments are referenced in the "Documents" section
    cms_eval_email_evaluators_comps.text_docs_uploaded_list(case_state.case_uploaded_file_name_1)

    # Retrieve the "unique-case-specific-link" from the email template
    # https://dev.get-help-buying-for-schools.service.gov.uk/evaluation/verify/evaluator/link/42c3bc0b-c711-478f-88dd-014b835c472e
    case_state.case_eval_case_specific_link = cms_eval_email_evaluators_comps.unique_case_specific_link_href

    # Ensure the "GHBS Participation Agreement Inc FOI.pdf" is attached
    cms_eval_email_evaluators_comps.link_attachments_added("GHBS Participation Agreement Inc FOI.pdf")

    # Send the email. / Return to the main menu
    cms_eval_email_evaluators_comps.button_send_email_and_continue.click
    expect(page).to have_current_path(%r{/support/cases/}, url: true, wait: 10)
    expect(cms_eval_task_list_comps.text_section_heading.text).to include("Procurement task list")
    expect(cms_eval_task_list_comps.text_email_evaluators_status.text).to include("Complete")
  end

  def complete_review_evaluations
    # TODO
  end
end
