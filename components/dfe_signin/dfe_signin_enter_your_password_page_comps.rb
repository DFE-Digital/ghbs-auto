# frozen_string_literal: true

class DfESignInEnterYourPasswordPageComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def input_password
    find(:xpath, "//input[@id = 'password']")
  end

  def button_next
    find(:xpath, "//button[text()='Next']")
  end
end
