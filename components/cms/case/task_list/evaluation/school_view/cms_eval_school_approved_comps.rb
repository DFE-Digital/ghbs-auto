# frozen_string_literal: true

class CmsEvalSchoolApprovedComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def text_case_number_and_school_name
    find(:xpath, "//h1/preceding-sibling::span")
  end

  def button_cancel
    find(:xpath, "//a[text()='Cancel']")
  end

  def button_continue
    find(:xpath, "//input[@value='Continue']")
  end
end
