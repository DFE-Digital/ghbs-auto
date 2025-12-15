# frozen_string_literal: true

class CmsSingleCaseNavComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def link_task_list
    find(:xpath, "//a[text()='Task list']")
  end

  def link_school_details
    find(:xpath, "//a[text()='School details']")
  end

  def link_case_details
    find(:xpath, "//a[text()='Case details']")
  end

  def link_request
    find(:xpath, "//a[text()='Request']")
  end

  def link_messages
    find(:xpath, "//a[text()='Messages']")
  end

  def link_case_history
    find(:xpath, "//a[text()='Case history']")
  end

  def link_attachments
    find(:xpath, "//a[text()='Attachments']")
  end

  def link_files
    find(:xpath, "//a[text()='Files']")
  end
end
