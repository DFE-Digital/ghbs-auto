# frozen_string_literal: true

class EnergyGasBillConsolidatedComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  # Do you want your MPRNs consolidated on one bill?
  def radio_bill_yes
    find(:xpath, "//input[@id='gas-bill-consolidation-form-gas-bill-consolidation-true-field']")
  end

  def radio_bill_no
    find(:xpath, "//input[@id='gas-bill-consolidation-form-gas-bill-consolidation-field']")
  end

  # Form completion
  def button_save_and_continue
    find(:xpath, "//input[@type='submit' and @value='Save and continue']")
  end

  def link_go_to_task_list
    find(:xpath, "//a[text()='Discard and go to task list']")
  end
end
