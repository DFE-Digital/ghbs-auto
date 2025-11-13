# frozen_string_literal: true

class EnergyCheckYourAnswersComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  # Current contract details
  def link_change_gas_contract
    find(:xpath, "//a[text()='gas_contract_information_change']")
  end

  def text_current_gas_supplier
    find(:xpath, "//dt[text()='Current gas supplier']/following-sibling::dd")
  end

  def text_when_does_your_contract_end
    find(:xpath, "//dt[text()='When does your contract end']/following-sibling::dd")
  end

  # Gas meters and usage
  def link_change_gas_meter_usage
    find(:xpath, "//a[text()='gas_meters_and_usage_change']")
  end

  def text_gas_single_or_multi_meter
    find(:xpath, "//dt[text()='Is this a single meter or multi meter site?']/following-sibling::dd")
  end

  def text_gas_meter_point_reference_number_1
    find(:xpath, "//dt[text()='Meter Point Reference Number']/following-sibling::dd")
  end

  def text_gas_estimated_annual_gas_usage_1
    find(:xpath, "//dt[text()='Estimated annual gas usage']/following-sibling::dd")
  end

  # Site contact details
  def link_change_site_contact
    find(:xpath, "//a[text()='site_contact_details_change']")
  end

  def text_site_contact_name
    find(:xpath, "//dt[text()='Contact name']/following-sibling::dd")
  end

  def text_site_contact_email
    find(:xpath, "//dt[text()='Email']/following-sibling::dd")
  end

  def text_site_contact_phone
    find(:xpath, "//dt[text()='Telephone']/following-sibling::dd")
  end

  # VAT Declaration
  def link_change_vat_declaration
    find(:xpath, "//a[text()='vat_declaration_change']")
  end

  def text_vat_rate
    find(:xpath, "//dt[text()='VAT rate']/following-sibling::dd")
  end

  # Billing preferences
  def link_change_billing_pref
    find(:xpath, "//a[text()='billing_preferences_change']")
  end

  def text_billing_how_will_you_pay
    find(:xpath, "//dt[text()='How will you pay your bills?']/following-sibling::dd")
  end

  def text_billing_payment_terms
    find(:xpath, "//dt[text()='Payment terms']/following-sibling::dd")
  end

  def text_billing_how_would_you_like_to_receive
    find(:xpath, "//dt[text()='How would you like to receive your bills?']/following-sibling::dd")
  end

  def text_billing_address
    find(:xpath, "//dt[text()='Address for invoice']/following-sibling::dd")
  end

  # Form completion
  def button_continue
    find(:xpath, "//a[text()='Continue']")
  end
end
