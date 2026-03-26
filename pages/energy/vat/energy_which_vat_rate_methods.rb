# frozen_string_literal: true

require "date"
require "pages/energy/energy_base_page"
require "helpers/unique_content_helpers"
require "components/energy/vat/energy_which_vat_rate_comps"
require "components/energy/billing/energy_billing_pref_comps"
require "components/energy/vat/energy_are_these_correct_vat_details_comps"
require "components/energy/vat/energy_vat_certificate_comps"

class EnergyWhichVatRateMethods < EnergyBasePage
  include UniqueContentHelpers

  def percentage_choice(vat_choice)
    if vat_choice == "20"
      complete_with_20_percentage_vat
    end

    if vat_choice == "5"
      complete_with_5_percentage_vat
    end
  end

  def complete_with_20_percentage_vat
    # Set vat percentage
    energy_which_vat_rate_comps.radio_20_percent.click

    # Axe Check
    axe_check! if FlagsGlobalConfig.axe_enabled?

    # Add to case state
    case_state.vat_rate = "20%"

    ### Confirm we have been sent to billing preferences
    energy_which_vat_rate_comps.button_save_and_continue.click
    expect(page).to have_current_path(%r{/energy/billing-preferences/}, url: true, wait: 10)
    expect(energy_billing_pref_comps.text_page_heading.text).to include("Billing preferences")
  end

  def complete_with_5_percentage_vat
    ### Which VAT rate are you charged?
    total_consumption_percent = generate_random_number_in_range(1, 100, preserve_leading_zeros: false)
    vat_reg_number = generate_random_number(9, preserve_leading_zeros: true)
    energy_which_vat_rate_comps.radio_5_percent.click

    # Excluding known axe false-positive for GOV.UK conditional reveal radio
    # (`aria-expanded` flagged by `aria-allowed-attr`).
    # Axe Check
    if FlagsGlobalConfig.axe_enabled?
      axe_check!(
        exclude: "#vat-rate-charge-vat-rate-5-field",
        label: "Known axe exception for GOV-style conditional reveal radio"
      )
    end

    # Percentage of total consumption qualifying for reduced rate of VAT
    energy_which_vat_rate_comps.input_total_consumption_percent.set(total_consumption_percent)

    # VAT registration number (optional)
    energy_which_vat_rate_comps.input_vat_reg_number.set(vat_reg_number)

    # Excluding known axe false-positive for GOV.UK conditional reveal radio
    # (`aria-expanded` flagged by `aria-allowed-attr`).
    # Axe Check
    if FlagsGlobalConfig.axe_enabled?
      axe_check!(
        exclude: "#vat-rate-charge-vat-rate-5-field",
        label: "Known axe exception for GOV-style conditional reveal radio"
      )
    end

    # Add to case state
    case_state.vat_rate = "5%"
    case_state.vat_qualifying_percentage = total_consumption_percent.to_s
    case_state.vat_reg_number = vat_reg_number.to_s

    ### Are these the correct details for VAT purposes?
    energy_which_vat_rate_comps.button_save_and_continue.click
    expect(page).to have_current_path(%r{/energy/vat-contact/}, url: true, wait: 10)
    expect(energy_are_these_correct_vat_details_comps.text_page_heading.text).to include("Are these the correct details for VAT purposes?")

    # Add to case state
    case_state.vat_contact_name = energy_are_these_correct_vat_details_comps.text_name.text
    case_state.vat_contact_phone = energy_are_these_correct_vat_details_comps.text_phone.text
    case_state.vat_contact_address = energy_are_these_correct_vat_details_comps.text_address.text

    # Confirm the details are correct and progress to the next page
    energy_are_these_correct_vat_details_comps.radio_yes.click

    # Axe Check
    axe_check! if FlagsGlobalConfig.axe_enabled?

    ### VAT certificate of declaration
    energy_are_these_correct_vat_details_comps.button_save_and_continue.click
    expect(page).to have_current_path(%r{/energy/vat-certificate/}, url: true, wait: 10)
    expect(energy_vat_certificate_comps.text_page_heading.text).to include("VAT certificate of declaration")

    # Complete the checkbox's
    energy_vat_certificate_comps.checkbox_1.click
    energy_vat_certificate_comps.checkbox_2.click
    energy_vat_certificate_comps.checkbox_3.click

    # Axe Check
    axe_check! if FlagsGlobalConfig.axe_enabled?

    # Add to case state
    case_state.vat_certificate_confirmation = "Yes"

    ### Confirm we have been sent to billing preferences
    energy_vat_certificate_comps.button_save_and_continue.click
    expect(page).to have_current_path(%r{/energy/billing-preferences/}, url: true, wait: 10)
    expect(energy_billing_pref_comps.text_page_heading.text).to include("Billing preferences")
  end
end
