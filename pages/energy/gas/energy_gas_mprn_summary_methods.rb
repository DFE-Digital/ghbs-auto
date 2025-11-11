# frozen_string_literal: true

require "date"
require "pages/energy/energy_base_page"
require "helpers/unique_content_helpers"
require "components/energy/gas/energy_gas_mprn_summary_comps"
require "components/energy/gas/energy_gas_bill_consolidated_comps"

class EnergyGasMprnSummaryMethods < EnergyBasePage
  def add_another_mprn
    energy_gas_mprn_summary_comps.button_add_another_mprn.click
  end

  def continue_to_gas_bill_consolidated
    energy_gas_mprn_summary_comps.button_save_and_continue.click
    expect(page).to have_current_path(%r{/gas-bill}, url: true, wait: 10)
    expect(energy_gas_bill_consolidated_comps.text_page_heading.text).to include("Do you want your MPRNs consolidated on one bill?")
  end
end
