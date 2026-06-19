# frozen_string_literal: true

require "pages/cms/cms_base_page"
require "components/cms/case/task_list/handover/school_view/cms_handover_download_contract_comps"
require "components/cms/case/task_list/handover/school_view/cms_handover_proc_task_list_comps"
require "helpers/validation_helpers"
require "helpers/upload_file_helpers"

class CmsCaseHandoverSchoolUserFlowMethods < CmsBasePage
  include ValidationHelpers
  include UploadFileHelpers

  def open_current_case_handover_for_school_user
    visit case_state.case_handover_case_specific_link
    expect(page).to have_current_path(%r{/my_procurements/tasks/}, url: true, wait: 10)
    expect(cms_handover_proc_task_list_comps.text_page_heading.text).to include("Procurement task list")
    expect(cms_handover_proc_task_list_comps.text_download_contract_handover_pack_status.text).to include("To do")
  end

  def complete_download_documents
    # Open 'Download contract handover pack' screen
    cms_handover_proc_task_list_comps.link_download_contract_handover_pack.click
    expect(page).to have_current_path(%r{/my_procurements/download_handover_packs/}, url: true, wait: 10)
    expect(cms_handover_download_contract_comps.text_page_heading.text).to include("Download contract handover pack")

    # Select "Yes, I have downloaded all documents" radio
    cms_handover_download_contract_comps.radio_downloaded_docs_yes.click

    # Complete and leave the form
    cms_handover_download_contract_comps.button_continue.click
    expect(page).to have_current_path(%r{/my_procurements/tasks/}, url: true, wait: 10)
    expect(cms_handover_proc_task_list_comps.text_page_heading.text).to include("Procurement task list")
    expect(cms_handover_proc_task_list_comps.text_download_contract_handover_pack_status.text).to include("Complete")
  end
end
