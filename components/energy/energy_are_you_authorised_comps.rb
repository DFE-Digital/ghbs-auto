# frozen_string_literal: true

class EnergyAreYouAuthorisedPageComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def button_continue
    find(:xpath, "//a[text()='Continue']")
  end
end
