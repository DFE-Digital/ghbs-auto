# frozen_string_literal: true

class CmsLoginPageComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def button_start_now
    find(:xpath, "//button[normalize-space(text())='Sign in']")
  end
end