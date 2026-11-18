# frozen_string_literal: true

class RfhDoYouHaveARecentEnergyBillYouCanUploadComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//legend")
  end

  def link_back
    find(:xpath, "//a[text()='Back']")
  end

  def radio_yes
    find(:xpath, "//input[@id='framework-support-form-have-energy-bill-true-field']/following-sibling::label")
  end

  def radio_no
    find(:xpath, "//input[@id='framework-support-form-have-energy-bill-false-field']/following-sibling::label")
  end

  def button_continue
    find(:xpath, "//input[@value='Continue']")
  end
end
