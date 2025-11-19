# frozen_string_literal: true

class EnergyElectricBillConsolidatedComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  # Do you want your MPRNs consolidated on one bill?
  def radio_bill_yes
    find(:xpath, "//input[@id='electric-bill-consolidation-form-is-electric-bill-consolidated-true-field']/following-sibling::label")
  end

  def radio_bill_no
    find(:xpath, "//input[@id='electric-bill-consolidation-form-is-electric-bill-consolidated-field']/following-sibling::label")
  end

  # Form completion
  def button_save_and_continue
    find(:xpath, "//input[@type='submit' and @value='Save and continue']")
  end

  def link_go_to_task_list
    find(:xpath, "//a[text()='Discard and go to task list']")
  end
end
