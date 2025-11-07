# frozen_string_literal: true

class EnergyCheckYourAnswersComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  # Check your answers
  def link_change_gas_contract
    find(:xpath, "//a[text()='gas_contract_information_change']")
  end

  def link_change_gas_meter_usage
    find(:xpath, "//a[text()='gas_meters_and_usage_change']")
  end

  def link_change_site_contact
    find(:xpath, "//a[text()='site_contact_details_change']")
  end

  def link_change_vat_declaration
    find(:xpath, "//a[text()='vat_declaration_change']")
  end

  def link_change_billing_pref
    find(:xpath, "//a[text()='billing_preferences_change']")
  end

  # Form completion
  def button_continue
    find(:xpath, "//a[text()='Continue']")
  end
end
