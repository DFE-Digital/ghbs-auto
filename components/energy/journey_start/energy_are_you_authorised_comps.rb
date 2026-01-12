# frozen_string_literal: true

class EnergyAreYouAuthorisedComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  # Form completion
  def button_continue
    find(:xpath, "//a[text()='Continue']")
  end
end
