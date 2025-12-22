# frozen_string_literal: true

class DfeSignin2SelectYourOrgComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def text_success_invite(uid_line)
    find(:xpath, "//label/span[contains(.,'#{uid_line}')]")
  end

  def button_continue
    find(:xpath, "//button[text()='Continue']")
  end
end
