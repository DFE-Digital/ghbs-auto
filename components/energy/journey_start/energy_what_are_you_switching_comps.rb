# frozen_string_literal: true

class EnergyWhatAreYouSwitchingComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def radio_electric_only
    find(:xpath, "//input[@id='energy-type-form-switching-energy-type-electricity-field']/following-sibling::label")
  end

  def radio_gas_only
    find(:xpath, "//input[@id='energy-type-form-switching-energy-type-gas-field']/following-sibling::label")
  end

  def radio_both_electric_and_gas
    find(:xpath, "//input[@id='energy-type-form-switching-energy-type-gas-electricity-field']/following-sibling::label")
  end

  # Form completion
  def button_save_and_continue
    find(:xpath, "//input[@type='submit' and @value='Save and continue']")
  end
end
