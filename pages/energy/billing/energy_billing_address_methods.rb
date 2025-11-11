# frozen_string_literal: true

require "pages/energy/energy_base_page"
require "components/energy/billing/energy_billing_address_comps"
require "components/energy/completion/energy_check_your_answers_comps"

class EnergyBillingAddressMethods < EnergyBasePage
  def choose_address_in_position(address_position)
    # Billing address
    case address_position
    when "1"
      energy_billing_address_comps.radio_address_option_1.click
    when "2"
      energy_billing_pref_comps.radio_address_option_2.click
    else
      raise ArgumentError, "Unknown address position choice: #{type.inspect}, expected 1 or 2"
    end
  end

  def continue_to_check_your_answers
    energy_billing_pref_comps.button_save_and_continue.click
    expect(page).to have_current_path(%r{/check-answers}, url: true, wait: 10)
    expect(energy_check_your_answers_comps.text_page_heading.text).to include("Check your answers")
  end
end
