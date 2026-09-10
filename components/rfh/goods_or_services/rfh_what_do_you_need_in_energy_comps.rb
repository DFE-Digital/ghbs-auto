# frozen_string_literal: true

class RfhWhatDoYouNeedInEnergyComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//legend/h1")
  end

  def link_back
    find(:xpath, "//a[text()='Back']")
  end

  def radio_decarbonisation_and_energy_efficiency
    find(:xpath, "//input[@id='framework-support-form-category-slug-decarbonisation-and-energy-efficiency-field']/following-sibling::label")
  end

  def radio_electricity
    find(:xpath, "//input[@id='framework-support-form-category-slug-electricity-field']/following-sibling::label")
  end

  def radio_gas
    find(:xpath, "//input[@id='framework-support-form-category-slug-gas-field']/following-sibling::label")
  end

  def radio_heat_pumps
    find(:xpath, "//input[@id='framework-support-form-category-slug-heat-pumps-field']/following-sibling::label")
  end

  def radio_leds
    find(:xpath, "//input[@id='framework-support-form-category-slug-leds-field']/following-sibling::label")
  end

  def radio_other_fuels
    find(:xpath, "//input[@id='framework-support-form-category-slug-other-fuels-field']/following-sibling::label")
  end

  def radio_solar
    find(:xpath, "//input[@id='framework-support-form-category-slug-solar-field']/following-sibling::label")
  end

  def radio_water
    find(:xpath, "//input[@id='framework-support-form-category-slug-water-field']/following-sibling::label")
  end

  def radio_other
    find(:xpath, "//input[@id='framework-support-form-category-slug-other-field']/following-sibling::label")
  end

  def input_other
    find(:xpath, "//textarea[@id='framework-support-form-category-other-field']")
  end

  def button_continue
    find(:xpath, "//input[@value='Continue']")
  end
end
