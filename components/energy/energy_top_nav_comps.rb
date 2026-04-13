# frozen_string_literal: true

class EnergyTopNavComps
  include Capybara::DSL

  # Very top nav
  def text_signed_in_as
    find(:xpath, "//div[@class='govuk-header__signed-in-user']")
  end

  # Top middle nav
  def link_get_help_buying_for_schools
    find(:xpath, "//a[contains(.,'Get help buying for schools')]")
  end

  def link_sign_out
    find(:xpath, "//ul[@aria-label='Top level navigation']/li/a")
  end

  def text_flash_notice
    find(:xpath, "//div[@id='flash_notice']")
  end
end
