# frozen_string_literal: true

class CmsSingleCaseAssignToCaseWorkerComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def input_search_for_case_worker_name
    find(:xpath, "//input[@id='agent-autocomplete']")
  end

  def dropdown_select_case_worker_name(case_worker_name)
    find(:xpath, "//ul[@id='agent-autocomplete__listbox']/li[contains(.,'#{case_worker_name}')]")
  end

  def button_assign
    find(:xpath, "//input[@value='Assign']")
  end
end
