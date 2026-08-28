# frozen_string_literal: true

require "pages/shared/shared_global_methods"
require "pages/rfh/rfh_base_page"
require "components/rfh/uploads/rfh_docs_you_want_to_upload_comps"
require "components/rfh/uploads/rfh_upload_your_docs_comps"
require "components/rfh/uploads/rfh_your_files_have_been_uploaded_comps"
require "helpers/validation_helpers"
require "helpers/logger_helpers"
require "helpers/upload_file_helpers"

class RfhUploadMethods < RfhBasePage
  include ValidationHelpers
  include LoggerHelpers
  include UploadFileHelpers

  def complete_any_docs_to_share_with_us
    # Confirm we are on the "Are there any documents that you would like to upload and share with us?" screen
    expect(page).to have_current_path(%r{/procurement-support/documents}, url: true, wait: 10)
    expect(rfh_docs_you_want_to_upload_comps.text_page_heading.text).to include("Are there any documents that you would like to upload and share with us?")

    # Select that you want to upload other and say its test docs
    rfh_docs_you_want_to_upload_comps.checkbox_other_please_specify.click
    rfh_docs_you_want_to_upload_comps.input_other_please_specify.set("Auto test data")

    # Move on to the next screen
    rfh_docs_you_want_to_upload_comps.button_continue.click
  end

  def complete_upload_your_docs
    # Confirm we are on the "Upload your documents" screen
    expect(page).to have_current_path(%r{/procurement-support/document_uploads}, url: true, wait: 10)
    expect(rfh_upload_your_docs_comps.text_page_heading.text).to include("Upload your documents")

    # Upload the test file via Dropzone
    upload_file_via_dropzone("resources/test_data/evaluation_doc.txt", input_selector: 'input[type="file"].dz-hidden-input')

    # Validate the document is uploaded
    expect(page).to have_xpath(rfh_upload_your_docs_comps.text_files_added_heading_xpath, wait: 5)
    wait_for_element_to_include(rfh_upload_your_docs_comps.text_uploaded_file_name, "evaluation_doc.txt", timeout: 5)

    # Set the state to confirm we have only uploaded a single test doc
    rfh_state.documents_attached = "1"

    # Confirm all docs are uploaded and proceed to upload page
    rfh_upload_your_docs_comps.button_continue_to_upload.click
  end

  def complete_your_files_have_been_uploaded
    # Confirm we are on the "Your files have been uploaded" screen
    expect(page).to have_current_path(%r{/procurement-support/document_uploads}, url: true, wait: 10)
    wait_for_element_to_include(rfh_your_files_have_been_uploaded_comps.text_page_heading, "Your files have been uploaded", timeout: 5)

    # Validate the file has been uploaded successfully
    wait_for_element_to_include(rfh_your_files_have_been_uploaded_comps.text_file_name, "evaluation_doc.txt", timeout: 5)
    wait_for_element_to_include(rfh_your_files_have_been_uploaded_comps.text_file_status, "Complete", timeout: 5)

    # Confirm all docs are uploaded and proceed to upload page
    rfh_your_files_have_been_uploaded_comps.button_continue.click
  end
end
