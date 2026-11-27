# frozen_string_literal: true

class CmsCaseActionsAssignToCaseWorkerComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def input_search_for_case_worker_name
    find(:xpath, "//input[@id='case_assignment_form_agent_id' and @aria-describedby='case_assignment_form_agent_id__assistiveHint']")
  end

  def dropdown_select_case_worker_name(case_worker_name)
    find(:xpath, "//ul[@id='case_assignment_form_agent_id__listbox']/li[contains(.,'#{case_worker_name}')]")
  end

  def button_assign
    find(:xpath, "//input[@value='Assign']")
  end
end
