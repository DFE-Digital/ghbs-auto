# frozen_string_literal: true

class CssP1StartComps
  include Capybara::DSL

  # Page: Get help buying for schools feedback
  def text_page_heading
    find(:xpath, "//h1")
  end

  def button_continue
    find(:xpath, "//button[text()='Continue']")
  end

end
