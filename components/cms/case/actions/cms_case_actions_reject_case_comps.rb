# frozen_string_literal: true

class CmsCaseActionsRejectCaseComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//legend")
  end

  def radio_reason_no_engagement
    find(:xpath, "//input[@id='case-closure-form-reason-no-engagement-field']/following-sibling::label")
  end

  def radio_reason_spam
    find(:xpath, "//input[@id='case-closure-form-reason-spam-field']/following-sibling::label")
  end

  def radio_reason_out_of_scope
    find(:xpath, "//input[@id='case-closure-form-reason-out-of-scope-field']/following-sibling::label")
  end

  def radio_reason_test_case
    find(:xpath, "//input[@id='case-closure-form-reason-test-case-field']/following-sibling::label")
  end

  def radio_reason_objections_resulted_in_cancellation
    find(:xpath, "//input[@id='case-closure-form-reason-objections-field']/following-sibling::label")
  end

  def radio_reason_other
    find(:xpath, "//input[@id='case-closure-form-reason-objections-field']/following-sibling::label")
  end

  def button_save_and_reject_case
    find(:xpath, "//input[@value='Save and reject case']")
  end
end
