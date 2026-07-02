# frozen_string_literal: true

class FabsMainMenuDropdownComps
  include Capybara::DSL

  # Button
  def button_main_dropdown_menu
    find(:xpath, "//button[@aria-controls='super-navigation-menu']")
  end

  # Text
  def text_guidance_and_support
    find(:xpath, "//h3[contains(.,'Guidance and support')]")
  end

  def div_super_nav_menu
    find(:xpath, "//div[@id='super-navigation-menu']")
  end


end
