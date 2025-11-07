# frozen_string_literal: true

class EnergyGasContractComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  # Who currently supplies your gas?
  def radio_supplier_british_gas
    find(:xpath, "//input[@id='gas-supplier-form-gas-current-supplier-british-gas-field']/following-sibling::label")
  end

  def radio_supplier_edf_energy
    find(:xpath, "//input[@id='gas-supplier-form-gas-current-supplier-edf-energy-field']/following-sibling::label")
  end

  def radio_supplier_eon_next
    find(:xpath, "//input[@id='gas-supplier-form-gas-current-supplier-eon-next-field']/following-sibling::label")
  end

  def radio_supplier_scottish_power
    find(:xpath, "//input[@id='gas-supplier-form-gas-current-supplier-scottish-power-field']/following-sibling::label")
  end

  def radio_supplier_ovo_energy
    find(:xpath, "//input[@id='gas-supplier-form-gas-current-supplier-ovo-energy-field']/following-sibling::label")
  end

  def radio_supplier_octopus_energy
    find(:xpath, "//input[@id='gas-supplier-form-gas-current-supplier-octopus-energy-field']/following-sibling::label")
  end

  def radio_supplier_other
    find(:xpath, "//input[@id='gas-current-supplier-other-radio']/following-sibling::label")
  end

  def input_other
    find(:xpath, "//input[@id='gas-supplier-form-gas-current-supplier-other-field']")
  end

  # When does the contract end?
  def input_contract_end_day
    find(:xpath, "//input[@id='gas_supplier_form_gas_current_contract_end_date_3i']")
  end

  def input_contract_end_month
    find(:xpath, "//input[@id='gas_supplier_form_gas_current_contract_end_date_2i']")
  end

  def input_contract_end_year
    find(:xpath, "//input[@id='gas_supplier_form_gas_current_contract_end_date_1i']")
  end

  # Form completion
  def button_save_and_continue
    find(:xpath, "//input[@type='submit' and @value='Save and continue']")
  end

  def link_go_to_task_list
    find(:xpath, "//a[text()='Discard and go to task list']")
  end
end
