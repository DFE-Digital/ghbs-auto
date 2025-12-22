# frozen_string_literal: true

class DfeSigninEnterYourPasswordPageComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//div[@id='loginHeader']/div")
  end

  def text_page_heading_test_server
    find(:xpath, "//h1")
  end

  def input_password
    find(:xpath, "//input[@name = 'passwd']")
  end

  def input_password_test_server
    find(:xpath, "//input[@name = 'password']")
  end

  def button_sign_in
    find(:xpath, "//input[@id='idSIButton9']")
  end

  def button_sign_in_test_server
    find(:xpath, "//button[contains(.,'Sign in')]")
  end


end
