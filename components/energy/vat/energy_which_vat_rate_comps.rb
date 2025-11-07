# frozen_string_literal: true

class EnergyWhichVatRateComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  # Which VAT rate are you charged?
  def radio_20_percent
    find(:xpath, "//input[@id='vat-rate-charge-vat-rate-20-field']")
  end

  def radio_5_percent
    find(:xpath, "//input[@id='vat-rate-charge-vat-rate-5-field']")
  end

  def input_total_consumption_percent
    find(:xpath, "//input[@id='vat-rate-charge-vat-lower-rate-percentage-field']")
  end

  def input_vat_reg_number
    find(:xpath, "//input[@id='vat-rate-charge-vat-lower-rate-reg-no-field']")
  end

  # Form completion
  def button_save_and_continue
    find(:xpath, "//input[@type='submit' and @value='Save and continue']")
  end

  def link_go_to_task_list
    find(:xpath, "//a[text()='Discard and go to task list']")
  end
end
