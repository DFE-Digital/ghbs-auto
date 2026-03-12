# frozen_string_literal: true

class CmsCaseActionsReopenCaseComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def button_reopen_the_case
    find(:xpath, "//a[contains(.,'Reopen the case')]")
  end

  def button_cancel
    find(:xpath, "//a[text()='Cancel']")
  end
end
