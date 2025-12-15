# frozen_string_literal: true

class CmsEvalUploadDocumentsComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "h1")
  end

  def button_back
    find(:xpath, "//a[text()='Back']")
  end

  def button_choose_file
    find(:xpath, "//span[@data-case-files-target='btnDisplayFileDialog']")
  end

  def radio_no
    find(:xpath, "//label[@for='document_uploader_has_uploaded_documents_false']")
  end

  def radio_yes
    find(:xpath, "//label[@for='document_uploader_has_uploaded_documents_true']")
  end

  def button_cancel
    find(:xpath, "//a[text()='Cancel']")
  end

  def button_continue
    find(:xpath, "//input[@value='Continue']")
  end
end
