# frozen_string_literal: true

class RfhWhenContractStartComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//legend")
  end

  def link_back
    find(:xpath, "//a[text()='Back']")
  end

  def radio_yes
    find(:xpath, "//input[@id='framework-support-form-contract-start-date-known-true-field']/following-sibling::label")
  end

  def radio_no
    find(:xpath, "//input[@id='framework-support-form-contract-start-date-known-field']/following-sibling::label")
  end

  def input_day
    find(:xpath, "//input[@id='framework_support_form_contract_start_date_3i']")
  end

  def input_month
    find(:xpath, "//input[@id='framework_support_form_contract_start_date_2i']")
  end

  def input_year
    find(:xpath, "//input[@id='framework_support_form_contract_start_date_1i']")
  end

  def button_continue
    find(:xpath, "//input[@value='Continue']")
  end
end
