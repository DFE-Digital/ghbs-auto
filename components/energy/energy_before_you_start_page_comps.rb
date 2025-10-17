# frozen_string_literal: true

class EnergyBeforeYouStartPageComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def button_continue
    find(:xpath, "//button[text()='Continue']")
  end
end
