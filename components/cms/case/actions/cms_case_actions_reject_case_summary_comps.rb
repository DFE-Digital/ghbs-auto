# frozen_string_literal: true

class CmsCaseActionsRejectCaseSummaryComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def button_reject_case
    find(:xpath, "//input[@value='Reject case']")
  end

  def button_cancel
    find(:xpath, "//a[text()='Cancel']")
  end
end
