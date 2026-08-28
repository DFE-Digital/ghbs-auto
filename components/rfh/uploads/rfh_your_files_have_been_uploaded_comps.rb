# frozen_string_literal: true

class RfhYourFilesHaveBeenUploadedComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def link_back
    find(:xpath, "//a[text()='Back']")
  end

  def text_file_name
    find(:xpath, "//div[@class='upload-row file-details']")
  end

  def text_file_status
    find(:xpath, "//div[@class='upload-row file-details']/following-sibling::div/p")
  end

  def link_remove
    find(:xpath, "//a[text()='Remove']")
  end

  def button_continue
    find(:xpath, "//button[@id='btn-submit']")
  end

  def button_add_more_files
    find(:xpath, "//button[@id='btn-add-more-files']")
  end
end
