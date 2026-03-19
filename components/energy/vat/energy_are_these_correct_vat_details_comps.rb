# frozen_string_literal: true

class EnergyAreTheseCorrectVatDetailsComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  # Are these the correct details for VAT purposes?
  def radio_yes
    find(:xpath, "//input[@id='vat-person-responsible-vat-person-correct-details-true-field']/following-sibling::label")
  end

  def radio_no
    find(:xpath, "//input[@id='vat-person-responsible-vat-person-correct-details-field']/following-sibling::label")
  end

  # Form completion
  def button_save_and_continue
    find(:xpath, "//input[@type='submit' and @value='Save and continue']")
  end

  def text_name
    find(:xpath, "//dt[text()='Name']/following-sibling::dd")
  end

  def text_address
    find(:xpath, "//dt[text()='Address']/following-sibling::dd")
  end

  def text_phone
    find(:xpath, "//dt[text()='Telephone number']/following-sibling::dd")
  end

  def link_go_to_task_list
    find(:xpath, "//a[text()='Discard and go to task list']")
  end
end
