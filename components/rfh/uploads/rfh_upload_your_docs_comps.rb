# frozen_string_literal: true

class RfhUploadYourDocsComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def link_back
    find(:xpath, "//a[text()='Back']")
  end

  def link_upload_documents
    find(:xpath, "//a[text()='Upload documents']")
  end

  def text_files_added_heading_xpath
    "//div[@data-dropzone-target='filePreview']/h2"
  end

  def text_files_added_heading
    find(:xpath, text_files_added_heading_xpath)
  end

  def text_uploaded_file_name
    find(:xpath, "//div[@data-dropzone-target='filePreview']//h3")
  end

  def button_continue_to_upload
    find(:xpath, "//button[@id='btn-continue']")
  end
end
