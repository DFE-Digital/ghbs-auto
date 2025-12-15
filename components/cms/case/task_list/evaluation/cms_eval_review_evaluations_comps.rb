# frozen_string_literal: true

class CmsEvalReviewEvaluationsComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def text_evaluator_email_address(email_address)
    find(:xpath, "//label[text()='#{email_address}']")
  end

  def checkbox_completed_eval(email_address)
    find(:xpath, "//label[text()='#{email_address}']/parent::div/input")
  end

  def dropdown_evaluators_files(email_address)
    find(:xpath, "//label[text()='#{email_address}']/parent::div/following-sibling::details")
  end

  def individual_evaluators_files_list(email_address)
    find(:xpath, "//label[text()='#{email_address}']/parent::div/following-sibling::details//p")
  end

  def button_cancel
    find(:xpath, "//a[text()='Cancel']")
  end

  def button_continue
    find(:xpath, "//input[@value='Continue']")
  end
end
