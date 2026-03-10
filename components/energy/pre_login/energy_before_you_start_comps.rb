# frozen_string_literal: true

class EnergyBeforeYouStartComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def text_page_sub_heading
    find(:xpath, "//h1/following-sibling::h2")
  end

  # Form completion
  def button_continue
    find(:xpath, "//button[text()='Continue']")
  end
end
