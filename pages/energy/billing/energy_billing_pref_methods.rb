# frozen_string_literal: true

require "pages/energy/energy_base_page"
require "components/energy/billing/energy_billing_pref_comps"
require "components/energy/billing/energy_billing_address_comps"

class EnergyBillingPrefMethods < EnergyBasePage
  def how_bills_paid(bill_type)
    expect(page).to have_current_path(%r{/billing-preferences}, url: true, wait: 10)
    expect(energy_billing_pref_comps.text_page_heading.text).to include("Billing preferences")
    # How will the bills be paid?
    case bill_type
    when "bacs"
      energy_billing_pref_comps.radio_bacs.click
    when "direct debit"
      energy_billing_pref_comps.radio_direct_debit.click
    else
      raise ArgumentError, "Unknown bill type: #{bill_type.inspect}, expected bacs or direct debit"
    end
  end

  def payment_terms(option)
    # Payment terms
    case option
    when "14"
      energy_billing_pref_comps.radio_payment_14_days.click
    when "21"
      energy_billing_pref_comps.radio_payment_21_days.click
    when "28"
      energy_billing_pref_comps.radio_payment_28_days.click
    when "30"
      energy_billing_pref_comps.radio_payment_30_days.click
    else
      raise ArgumentError, "Unknown payment term: #{option.inspect}, expected 14,21,28 or 30"
    end
  end

  def how_to_invoice(type)
    # How do you want to be invoiced?
    case type
    when "email"
      energy_billing_pref_comps.radio_invoice_email.click
      energy_billing_pref_comps.input_invoice_email_address.set(SECRETS["test_user_2"])
    when "paper"
      energy_billing_pref_comps.radio_invoice_paper.click
    else
      raise ArgumentError, "Unknown invoice type: #{type.inspect}, expected email or paper"
    end
  end

  def continue_to_billing_address_page
    energy_billing_pref_comps.button_save_and_continue.click
    expect(page).to have_current_path(%r{/billing-address}, url: true, wait: 10)
    expect(energy_billing_address_comps.text_page_heading.text).to include("Billing address")
  end
end
