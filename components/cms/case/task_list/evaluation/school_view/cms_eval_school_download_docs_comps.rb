# frozen_string_literal: true

class CmsEvalSchoolDownloadDocsComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "h1")
  end

  def text_case_number_and_school_name
    find(:xpath, "//h1/preceding-sibling::span")
  end

  def link_download_link(document_name)
    find(:xpath, "//dl/div/dd/a[text()='#{document_name}']")
  end

  def radio_downloaded_docs_yes
    find(:xpath, "//a[text()='//label[@for='document_download_has_downloaded_documents_true']']")
  end

  def radio_downloaded_docs_no
    find(:xpath, "//label[@for='document_download_has_downloaded_documents_false']")
  end

  def button_cancel
    find(:xpath, "//a[text()='Cancel']")
  end

  def button_continue
    find(:xpath, "//input[@value='Continue']")
  end
end
