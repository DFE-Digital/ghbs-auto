# frozen_string_literal: true

class DfeSigninVerifyYourIdentityComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//div[@role='heading']")
  end

  def button_email_code_to
    find(:xpath, "//div[@data-testid='mainText']")
  end

  def button_cancel
    find(:xpath, "//button[@id='credPickerSecondaryButton']")
  end
end
