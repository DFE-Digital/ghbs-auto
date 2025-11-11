# frozen_string_literal: true

require "date"
require "pages/energy/energy_base_page"
require "helpers/unique_content_helpers"
require "components/energy/site_access/energy_site_access_comps"
require "components/energy/vat/energy_which_vat_rate_comps"

class EnergySiteAccessMethods < EnergyBasePage
  include UniqueContentHelpers

  def complete_with_unique_data
    # Validate were on the correct page as there are multiple routes in to this screen (hence why this val isn't a page back!)
    expect(page).to have_current_path(%r{/site-contact}, url: true, wait: 10)
    expect(energy_what_are_you_switching_comps.text_page_heading.text).to include("Who manages site access and maintenance?")

    # Auto populate unique data
    energy_site_access_comps.input_first_name.set("AutoTestFN-#{Time.now.strftime('%S-%M-%H-%m-%d-%Y')}")
    energy_site_access_comps.input_last_name.set("AutoTestLN")
    energy_site_access_comps.input_email.set(SECRETS["test_user_2"])
    energy_site_access_comps.input_phone.set(generate_random_number(11, preserve_leading_zeros: true))
  end

  def continue_to_which_vat_rate_page
    energy_site_access_comps.button_save_and_continue.click
    expect(page).to have_current_path(%r{/vat-rate}, url: true, wait: 10)
    expect(energy_which_vat_rate_comps.text_page_heading.text).to include("Which VAT rate are you charged?")
  end
end
