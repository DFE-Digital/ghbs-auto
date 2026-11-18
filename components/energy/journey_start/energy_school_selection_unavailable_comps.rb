# frozen_string_literal: true

class EnergySchoolSelectionUnavailableComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  # Form completion
  def xpath_link_ryi
    "//a[text()='Register your interest form']"
  end

  def link_ryi
    find(:xpath, xpath_link_ryi)
  end
end
