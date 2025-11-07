# frozen_string_literal: true

class EnergyTaskListComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  # Task list
  def link_gas_contract_information
    find(:xpath, "//a[contains(.,'Gas contract information')]")
  end

  def link_gas_meter_and_usage
    find(:xpath, "//a[contains(.,'Gas meter and usage')]")
  end

  def link_site_contact_details
    find(:xpath, "//a[contains(.,'Site contact details')]")
  end

  def link_vat_declaration
    find(:xpath, "//a[contains(.,'VAT declaration')]")
  end

  def link_billing_preferences
    find(:xpath, "//a[contains(.,'Billing preferences')]")
  end

  # Form Completion
  def button_continue
    find(:xpath, "//a[text()='Continue']")
  end
end
