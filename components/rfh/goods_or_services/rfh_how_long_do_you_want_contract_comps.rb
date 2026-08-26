# frozen_string_literal: true

class RfhHowLongDoYouWantContractComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//legend")
  end

  def link_back
    find(:xpath, "//a[text()='Back']")
  end

  def radio_1_year
    find(:xpath, "//input[@id='framework-support-form-contract-length-one-year-field']/following-sibling::label")
  end

  def radio_2_year
    find(:xpath, "//input[@id='framework-support-form-contract-length-two-years-field']/following-sibling::label")
  end

  def radio_3_year
    find(:xpath, "//input[@id='framework-support-form-contract-length-three-years-field']/following-sibling::label")
  end

  def radio_4_year
    find(:xpath, "//input[@id='framework-support-form-contract-length-four-years-field']/following-sibling::label")
  end

  def radio_5_year
    find(:xpath, "//input[@id='framework-support-form-contract-length-five-years-field']/following-sibling::label")
  end

  def radio_not_sure
    find(:xpath, "//input[@id='framework-support-form-contract-length-not-sure-field']/following-sibling::label")
  end

  def input_other
    find(:xpath, "//textarea[@id='framework-support-form-category-other-field']")
  end

  def button_continue
    find(:xpath, "//input[@value='Continue']")
  end
end
