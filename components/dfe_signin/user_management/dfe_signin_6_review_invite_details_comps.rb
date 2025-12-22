# frozen_string_literal: true

class DfeSignin6ReviewInviteDetailsComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def button_submit
    find(:xpath, "//button[text()='Submit']")
  end
end
