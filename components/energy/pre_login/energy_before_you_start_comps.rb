# frozen_string_literal: true

class EnergyBeforeYouStartComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  # Form completion
  def button_continue
    find(:xpath, "//button[text()='Continue']")
  end
end
