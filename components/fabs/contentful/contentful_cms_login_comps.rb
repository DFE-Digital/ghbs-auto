# frozen_string_literal: true

class ContentfulCmsLoginComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1/span")
  end

  def input_email_address
    find(:xpath, "//input[@data-test-id='email-input']")
  end

  def input_password
    find(:xpath, "//input[@data-test-id='password-input']")
  end

  def button_login
    find(:xpath, "//button[@data-test-id='login-button']")
  end
end
