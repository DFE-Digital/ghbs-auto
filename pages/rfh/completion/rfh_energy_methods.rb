# frozen_string_literal: true

require "pages/shared/shared_global_methods"
require "pages/rfh/rfh_base_page"
require "components/rfh/uploads/energy/rfh_do_you_have_a_recent_energy_bill_you_can_upload_comps"
require "components/rfh/uploads/energy/rfh_upload_your_energy_info_comps"
require "helpers/validation_helpers"
require "helpers/logger_helpers"
require "helpers/upload_file_helpers"

class RfhEnergyMethods < RfhBasePage
  include ValidationHelpers
  include LoggerHelpers
  include UploadFileHelpers

  def complete_recent_energy_bill_upload_screen
    # Confirm we are on the "Do you have a recent energy bill you can upload?" screen
    expect(page).to have_current_path(%r{/procurement-support/energy_bill}, url: true, wait: 10)
    wait_for_element_to_include(rfh_do_you_have_a_recent_energy_bill_you_can_upload_comps.text_page_heading, "Do you have a recent energy bill you can upload?", timeout: 5)

    # Select the "yes" option to indicate you do have something to upload.
    rfh_do_you_have_a_recent_energy_bill_you_can_upload_comps.radio_yes.click

    # move on to the next screen
    rfh_do_you_have_a_recent_energy_bill_you_can_upload_comps.button_continue.click
  end

  def complete_upload_your_energy_info
    # Confirm we are on the "Upload your energy information" screen
    expect(page).to have_current_path(%r{/procurement-support/bill_uploads}, url: true, wait: 10)
    expect(rfh_upload_your_energy_info_comps.text_page_heading.text).to include("Upload your energy information")

    # Upload the test file via Dropzone
    upload_file_via_dropzone("resources/test_data/evaluation_doc.txt", input_selector: 'input[type="file"].dz-hidden-input')

    # Validate the document is uploaded
    expect(page).to have_xpath(rfh_upload_your_energy_info_comps.text_files_added_heading_xpath, wait: 5)
    wait_for_element_to_include(rfh_upload_your_energy_info_comps.text_uploaded_file_name, "evaluation_doc.txt", timeout: 5)

    # Set the state to confirm we have only uploaded a single test doc
    rfh_state.documents_attached = "1"
    rfh_state.bills_attached = "1"

    # Confirm all docs are uploaded and proceed to upload page
    rfh_upload_your_energy_info_comps.button_continue_to_upload.click
  end

  def complete_your_energy_files_have_been_uploaded
    # Confirm we are on the "Your files have been uploaded" screen (energy variant)
    expect(page).to have_current_path(%r{/procurement-support/bill_uploads}, url: true, wait: 10)
    wait_for_element_to_include(rfh_your_files_have_been_uploaded_comps.text_page_heading, "Your files have been uploaded", timeout: 5)

    # Validate the file has been uploaded successfully
    wait_for_element_to_include(rfh_your_files_have_been_uploaded_comps.text_file_name, "evaluation_doc.txt", timeout: 5)
    wait_for_element_to_include(rfh_your_files_have_been_uploaded_comps.text_file_status, "Complete", timeout: 5)

    # Confirm all docs are uploaded and proceed to upload page
    rfh_your_files_have_been_uploaded_comps.button_continue.click
  end
end
