# frozen_string_literal: true

class RfhApproxHowMuchComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//label")
  end

  def link_back
    find(:xpath, "//a[text()='Back']")
  end

  def input_amount
    find(:xpath, "//input[@id='framework-support-form-procurement-amount-field']")
  end

  def button_continue
    find(:xpath, "//input[@value='Continue']")
  end
end
