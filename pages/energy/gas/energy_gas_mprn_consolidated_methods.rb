# frozen_string_literal: true

require "date"
require "pages/energy/energy_base_page"
require "helpers/unique_content_helpers"
require "components/energy/gas/energy_gas_bill_consolidated_comps"

class EnergyGasMprnConsolidatedMethods < EnergyBasePage
  def bills_consolidated_yes
    energy_gas_bill_consolidated_comps.radio_bill_yes.click
  end

  def bills_consolidated_no
    energy_gas_bill_consolidated_comps.radio_bill_no.click
  end

  def continue_to_next_screen_based_on_flow
    # Next screen could be Electricity or Site Access
    energy_gas_bill_consolidated_comps.button_save_and_continue.click
  end
end
