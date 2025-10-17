# frozen_string_literal: true

class DfESignInAccessTheServicePageComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def input_username
    find(:xpath, "//input[@id = 'username']")
  end

  def button_sign_in
    find(:xpath, "//button[@id = 'button-sign-in']")
  end
end
