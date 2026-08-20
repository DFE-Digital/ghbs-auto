# frozen_string_literal: true

class RfhDoYouHaveADfeSigninAccountComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//legend")
  end

  def link_back
    find(:xpath, "//a[text()='Back']")
  end

  def radio_yes_use_dfe_sign_in
    find(:xpath, "//input[@id='framework-support-form-dsi-true-field']/following-sibling::label")
  end

  def radio_no_dont_use_dfe_sign_in
    find(:xpath, "//input[@id='framework-support-form-dsi-false-field']/following-sibling::label")
  end

  def button_continue
    find(:xpath, "//input[@value='Continue']")
  end
end
