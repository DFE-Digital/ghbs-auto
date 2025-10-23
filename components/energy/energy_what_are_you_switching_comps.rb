# frozen_string_literal: true

class EnergyWhatAreYouSwitchingPageComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def button_continue
    find(:xpath, "//input[@type='submit' and @value='Save and continue']")
  end
end
