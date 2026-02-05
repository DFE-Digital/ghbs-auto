# frozen_string_literal: true

class CmsSingleCaseOnboardingSummaryComps
  include Capybara::DSL

  def text_section_heading
    find(:xpath, "//h2[contains(.,'Onboarding summary')]")
  end

  # Current contract details
  def text_current_gas_supplier
    find(:xpath, "//dt[text()='Current gas supplier']/following-sibling::dd")
  end

  def text_when_does_your_gas_contract_end
    find(:xpath, "//dt[text()='Current gas supplier']/parent::div/following-sibling::div/dt[text()='When does your contract end']/following-sibling::dd")
  end

  def text_current_electric_supplier
    find(:xpath, "//dt[text()='Current electricity supplier']/following-sibling::dd")
  end

  def text_when_does_your_electric_contract_end
    find(:xpath, "//dt[text()='Current electricity supplier']/parent::div/following-sibling::div/dt[text()='When does your contract end']/following-sibling::dd")
  end

  # Gas meters and usage
  def text_gas_single_or_multi_meter
    find(:xpath, "//h3[text()='Gas meters and usage']/parent::div/following-sibling::div//dt[text()='Is this a single meter or multi meter site?']/following-sibling::dd")
  end

  def text_gas_meter_point_reference_number_1
    find(:xpath, "//dt[text()='Meter Point Reference Number']/following-sibling::dd")
  end

  def text_gas_estimated_annual_gas_usage_1
    find(:xpath, "//dt[text()='Estimated annual gas usage']/following-sibling::dd")
  end

  # Electricity meters and usage
  def text_electric_single_or_multi_meter
    find(:xpath, "//h3[text()='Electricity meters and usage']/parent::div/following-sibling::div//dt[text()='Is this a single meter or multi meter site?']/following-sibling::dd")
  end

  def text_electric_mpan_number_1
    find(:xpath, "//dt[text()='MPAN']/following-sibling::dd")
  end

  def text_electric_is_this_half_hour_1
    find(:xpath, "//dt[text()='Is this a half-hourly MPAN?']/following-sibling::dd")
  end

  def text_electric_estimated_annual_usage_kwh_1
    find(:xpath, "//dt[text()='Estimated annual electricity usage, in kilowatt hours (kWh)']/following-sibling::dd")
  end

  def text_electric_supply_capacity_1
    find(:xpath, "//dt[text()='What is the supply capacity?']/following-sibling::dd")
  end

  def text_electric_data_aggregator_1
    find(:xpath, "//dt[text()='Data aggregator']/following-sibling::dd")
  end

  def text_electric_data_collector_1
    find(:xpath, "//dt[text()='Data collector']/following-sibling::dd")
  end

  def text_electric_meter_operator_1
    find(:xpath, "//dt[text()='Meter operator']/following-sibling::dd")
  end

  # Site contact details
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
  def text_vat_rate
    find(:xpath, "//dt[text()='VAT rate']/following-sibling::dd")
  end

  # Billing preferences
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
end
