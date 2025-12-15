# frozen_string_literal: true

class CmsEvalSetDueDateComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "h1")
  end

  def input_day
    find(:xpath, "//input[@id='case_evaluation_due_date_form_evaluation_due_date_3i']")
  end

  def input_month
    find(:xpath, "//input[@id='case_evaluation_due_date_form_evaluation_due_date_2i']")
  end

  def input_year
    find(:xpath, "//input[@id='case_evaluation_due_date_form_evaluation_due_date_1i']")
  end

  def button_cancel
    find(:xpath, "//a[text()='Cancel']")
  end

  def button_continue
    find(:xpath, "//input[@value='Continue']")
  end
end
