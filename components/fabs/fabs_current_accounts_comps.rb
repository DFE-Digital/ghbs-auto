# frozen_string_literal: true

class FabsCurrentAccountsComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def link_barclays
    find(:xpath, "//a/strong[text()='Barclays']")
  end

  def link_lloyds_banking_group
    find(:xpath, "//a/strong[text()='Lloyds']")
  end

  def link_natwest
    find(:xpath, "//a/strong[text()='NatWest']")
  end

  def link_progressive_building_society
    find(:xpath, "//a/strong[text()='Progressive Building Society']")
  end

  def link_reliance_bank_limited
    find(:xpath, "//a/strong[text()='Reliance Bank Limited']")
  end

  def link_santander
    find(:xpath, "//a/strong[text()='Santander']")
  end

  def link_unity_trust_bank
    find(:xpath, "//a/strong[text()='Unity Trust Bank']")
  end
end
