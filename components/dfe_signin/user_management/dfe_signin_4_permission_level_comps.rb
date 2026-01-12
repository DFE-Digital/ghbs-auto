# frozen_string_literal: true

class DfeSignin4PermissionLevelComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def radio_end_user
    find(:xpath, "//label[text()='End user']")
  end

  def radio_approver
    find(:xpath, "//label[text()='Approver']")
  end

  def button_continue
    find(:xpath, "//button[text()='Continue']")
  end
end
