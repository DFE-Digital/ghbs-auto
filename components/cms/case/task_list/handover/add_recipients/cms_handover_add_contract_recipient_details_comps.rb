# frozen_string_literal: true

class CmsHandoverAddContractRecipientDetailsComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def input_first_name
    find(:xpath, "//input[@id='support-contract-recipient-first-name-field']")
  end

  def input_last_name
    find(:xpath, "//input[@id='support-contract-recipient-last-name-field']")
  end

  def input_email_address
    find(:xpath, "//input[@id='support-contract-recipient-email-field']")
  end

  def button_cancel
    find(:xpath, "//a[text()='Cancel']")
  end

  def button_save_changes
    find(:xpath, "//input[@value='Save changes']")
  end
end
