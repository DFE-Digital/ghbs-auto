# frozen_string_literal: true

class CmsIndividualCasePageComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def text_page_heading_case_number
    find(:xpath, "//p[@id='case-ref']/strong")
  end

  def text_flash_notice_content
    find(:xpath, "//div[@id='flash_notice']")
  end

  def text_case_status_badge
    find(:xpath, "//div[@id='case_status_badge']/strong")
  end
end
