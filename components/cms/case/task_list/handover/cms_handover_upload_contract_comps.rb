# frozen_string_literal: true

class CmsHandoverUploadContractComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def button_back
    find(:xpath, "//a[text()='Back']")
  end

  def button_choose_file
    find(:xpath, "//span[@data-case-files-target='btnDisplayFileDialog']")
  end

  def hidden_file_upload
    find(:xpath, "//input[@id='document-uploader-files-field' and @type='file']", visible: :all)
  end

  def text_uploaded_file_name(file_name)
    find(:xpath, "//h3[text()='File uploaded']/parent::div/parent::div/following-sibling::div//span[text()='#{file_name}']")
  end

  def radio_no
    find(:xpath, "//label[@for='document_uploader_has_uploaded_contract_handovers_false']")
  end

  def radio_yes
    find(:xpath, "//label[@for='document_uploader_has_uploaded_contract_handovers_true']")
  end

  def button_cancel
    find(:xpath, "//a[text()='Cancel']")
  end

  def button_continue
    find(:xpath, "//input[@value='Continue']")
  end
end
