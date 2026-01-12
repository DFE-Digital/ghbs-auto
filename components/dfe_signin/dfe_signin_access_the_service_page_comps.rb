# frozen_string_literal: true

class DfeSigninAccessTheServicePageComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def input_username
    find(:xpath, "//input[@id = 'username']")
  end

  def button_next
    find(:xpath, "//button[@id = 'button-next']")
  end
end
