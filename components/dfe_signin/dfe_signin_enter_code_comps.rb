# frozen_string_literal: true

class DfeSigninEnterCodeComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//div[@role='heading']")
  end

  def input_enter_code
    find(:xpath, "//input[@aria-label='Enter code']")
  end

  def button_cancel
    find(:xpath, "//button[@aria-label='Cancel']")
  end

  def button_verify
    find(:xpath, "//button[@aria-label='Verify']")
  end
end
