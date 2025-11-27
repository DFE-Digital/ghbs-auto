# frozen_string_literal: true

class DfeSigninEnterYourPasswordPageComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//div[@id='loginHeader']/div")
  end

  def input_password
    find(:xpath, "//input[@name = 'passwd']")
  end

  def button_sign_in
    find(:xpath, "//input[@id='idSIButton9']")
  end
end
