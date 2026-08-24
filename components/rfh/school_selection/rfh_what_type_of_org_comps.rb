# frozen_string_literal: true

class RfhWhatTypeOfOrgComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//legend")
  end

  def link_back
    find(:xpath, "//a[text()='Back']")
  end

  def radio_a_single_school
    find(:xpath, "//input[@id='framework-support-form-school-type-school-field']/following-sibling::label")
  end

  def radio_an_academy_trust_or_federation
    find(:xpath, "//input[@id='framework-support-form-school-type-group-field']/following-sibling::label")
  end

  def button_continue
    find(:xpath, "//input[@value='Continue']")
  end
end
