# frozen_string_literal: true

class EnergyStartComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  # Form completion
  def button_start_now
    find(:xpath, "//a[text()='Start now']")
  end
end
