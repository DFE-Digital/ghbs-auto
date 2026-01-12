# frozen_string_literal: true

class EnergyVatContactInfoComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  # Are these the correct details for VAT purposes?
  def input_first_name
    find(:xpath, "//input[@id='vat-alt-person-responsible-vat-alt-person-first-name-field']")
  end

  def input_last_name
    find(:xpath, "//input[@id='vat-alt-person-responsible-vat-alt-person-last-name-field']")
  end

  def input_phone
    find(:xpath, "//input[@id='vat-alt-person-responsible-vat-alt-person-phone-field']")
  end

  # Select an address
  def radio_address_option_1
    find(:xpath, "//h2[text()='Select an address']/parent::legend/following-sibling::div/div[1]/input")
  end

  def radio_address_option_2
    find(:xpath, "//h2[text()='Select an address']/parent::legend/following-sibling::div/div[2]/input")
  end

  # Form completion
  def button_save_and_continue
    find(:xpath, "//input[@type='submit' and @value='Save and continue']")
  end

  def link_go_to_task_list
    find(:xpath, "//a[text()='Discard and go to task list']")
  end
end
