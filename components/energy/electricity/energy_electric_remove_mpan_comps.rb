# frozen_string_literal: true

class EnergyElectricRemoveMpanComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def button_remove_mpan
    find(:xpath, "//a[text()='Remove MPAN']")
  end

  def link_cancel
    find(:xpath, "//a[text()='Cancel']")
  end
end
