# frozen_string_literal: true

class EnergyGasRemoveMprnComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def button_remove_mprn
    find(:xpath, "//a[text()='Remove MPRN']")
  end

  def link_cancel
    find(:xpath, "//a[text()='Cancel']")
  end
end
