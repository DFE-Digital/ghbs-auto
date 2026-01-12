# frozen_string_literal: true

class DfeSignin3inviteUserComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def input_first_name
    find(:xpath, "//input[@id='firstName']")
  end

  def input_last_name
    find(:xpath, "//input[@id='lastName']")
  end

  def input_email
    find(:xpath, "//input[@id='email']")
  end

  def button_continue
    find(:xpath, "//button[text()='Continue']")
  end
end
