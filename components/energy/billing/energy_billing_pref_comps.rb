# frozen_string_literal: true

class EnergyBillingPrefComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  # How will the bills be paid?
  def radio_bacs
    find(:xpath, "//input[@id='billing-preferences-billing-payment-method-bacs-field']/following-sibling::label")
  end

  def radio_direct_debit
    find(:xpath, "//input[@id='billing-preferences-billing-payment-method-direct-debit-field']/following-sibling::label")
  end

  # Payment terms
  def radio_payment_14_days
    find(:xpath, "//input[@id='billing-preferences-billing-payment-terms-days14-field']/following-sibling::label")
  end

  def radio_payment_21_days
    find(:xpath, "//input[@id='billing-preferences-billing-payment-terms-days21-field']/following-sibling::label")
  end

  def radio_payment_28_days
    find(:xpath, "//input[@id='billing-preferences-billing-payment-terms-days28-field']/following-sibling::label")
  end

  def radio_payment_30_days
    find(:xpath, "//input[@id='billing-preferences-billing-payment-terms-days30-field']/following-sibling::label")
  end

  # How do you want to be invoiced?
  def radio_invoice_email
    find(:xpath, "//input[@id='billing-preferences-billing-invoicing-method-email-field']/following-sibling::label")
  end

  def input_invoice_email_address
    find(:xpath, "//input[@id='billing-preferences-billing-invoicing-email-field']")
  end

  def radio_invoice_paper
    find(:xpath, "//input[@id='billing-preferences-billing-invoicing-method-paper-field']/following-sibling::label")
  end

  # Form completion
  def button_save_and_continue
    find(:xpath, "//input[@type='submit' and @value='Save and continue']")
  end

  def link_go_to_task_list
    find(:xpath, "//a[text()='Discard and go to task list']")
  end
end
