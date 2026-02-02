# frozen_string_literal: true

class FabsCurrentAccountsComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def link_barclays
    find(:xpath, "//a[text()='Barclays (opens in new tab)']")
  end

  def link_lloyds_banking_group
    find(:xpath, "//a[text()='Lloyds Banking Group (opens in new tab)']")
  end

  def link_natwest
    find(:xpath, "//a[text()='NatWest (opens in new tab)']")
  end

  def link_santander
    find(:xpath, "//a[text()='Santander (opens in new tab)']")
  end

  def link_unity_trust_bank
    find(:xpath, "//a[text()='Unity Trust Bank (opens in new tab)']")
  end
end
