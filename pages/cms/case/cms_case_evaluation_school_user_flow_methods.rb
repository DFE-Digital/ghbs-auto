# frozen_string_literal: true

require "pages/cms/cms_base_page"
require "components/cms/case/task_list/evaluation/school_view/cms_eval_school_approved_comps"
require "components/cms/case/task_list/evaluation/school_view/cms_eval_school_download_docs_comps"
require "components/cms/case/task_list/evaluation/school_view/cms_eval_school_task_list_comps"
require "components/cms/case/task_list/evaluation/school_view/cms_eval_school_upload_eval_scoring_comps"
require "helpers/validation_helpers"
require "helpers/upload_file_helpers"

class CmsCaseEvaluationSchoolUserFlowMethods < CmsBasePage
  include ValidationHelpers
  include UploadFileHelpers

  def open_current_case_evaluation_for_school_user
    visit case_state.case_eval_case_specific_link
    expect(page).to have_current_path(%r{/evaluation/tasks/}, url: true, wait: 10)
    expect(cms_eval_school_task_list_comps.text_page_heading.text).to include("Evaluator task list")
  end

  def complete_download_documents
    # Open Download documents screen
    cms_eval_school_task_list_comps.link_download_documents.click
    expect(page).to have_current_path(%r{/evaluation/download_documents/}, url: true, wait: 10)
    expect(cms_eval_school_download_docs_comps.text_page_heading.text).to include("Download documents")

    # Select "Yes, I have downloaded all documents" radio
    cms_eval_school_download_docs_comps.radio_downloaded_docs_yes.click

    # Complete and leave the form
    cms_eval_school_download_docs_comps.button_continue.click
    expect(page).to have_current_path(%r{/evaluation/tasks/}, url: true, wait: 10)
    expect(cms_eval_school_task_list_comps.text_page_heading.text).to include("Evaluator task list")
    expect(cms_eval_school_task_list_comps.text_download_documents_status.text).to include("Complete")
    expect(cms_eval_school_task_list_comps.text_upload_evaluation_scoring_document_status.text).to include("To do")
    expect(cms_eval_school_task_list_comps.text_evaluation_approved_by_dfe_status_pre_clickable.text).to include("Cannot start")
  end

  def complete_upload_evaluation_scoring_docs
    # Open Upload evaluation scoring document screen
    cms_eval_school_task_list_comps.link_upload_evaluation_scoring_document.click
    expect(page).to have_current_path(%r{/evaluation/upload_completed_documents/}, url: true, wait: 10)
    expect(cms_eval_school_upload_eval_scoring_comps.text_page_heading.text).to include("Upload evaluation scoring document")

    # Upload the test file via Dropzone
    upload_file_via_dropzone("resources/test_data/evaluation_school_upload_doc.txt", input_selector: 'input[type="file"].dz-hidden-input')
    case_state.case_school_eval_uploaded_file_name_1 = "evaluation_school_upload_doc.txt"

    # Validate the document is uploaded
    wait_for_heading_includes(cms_eval_school_upload_eval_scoring_comps.text_uploaded_file_name("evaluation_school_upload_doc.txt"), "evaluation_school_upload_doc.txt", timeout: 5)

    # Complete and leave the form
    cms_eval_school_upload_eval_scoring_comps.radio_uploaded_docs_yes.click
    cms_eval_school_upload_eval_scoring_comps.button_continue.click
    expect(page).to have_current_path(%r{/evaluation/tasks/}, url: true, wait: 10)
    expect(cms_eval_school_task_list_comps.text_page_heading.text).to include("Evaluator task list")
    expect(cms_eval_school_task_list_comps.text_download_documents_status.text).to include("Complete")
    expect(cms_eval_school_task_list_comps.text_upload_evaluation_scoring_document_status.text).to include("Complete")
    expect(cms_eval_school_task_list_comps.text_evaluation_approved_by_dfe_status_post_clickable.text).to include("In progress")
  end
end
