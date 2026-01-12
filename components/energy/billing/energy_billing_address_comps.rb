# frozen_string_literal: true

class EnergyBillingAddressComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  # Billing address
  def radio_address_option_1
    find(:xpath, "//h1[text()='Billing address']/parent::legend/following-sibling::div/div[1]/input/following-sibling::label")
  end

  def radio_address_option_2
    find(:xpath, "//h1[text()='Billing address']/parent::legend/following-sibling::div/div[2]/input/following-sibling::label")
  end

  # Form completion
  def button_save_and_continue
    find(:xpath, "//input[@type='submit' and @value='Save and continue']")
  end

  def link_go_to_task_list
    find(:xpath, "//a[text()='Discard and go to task list']")
  end
end
