# frozen_string_literal: true

class RfhWhatDoYouNeedInCleaningComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//legend/h1")
  end

  def link_back
    find(:xpath, "//a[text()='Back']")
  end

  def radio_cleaning_products
    find(:xpath, "//input[@id='framework-support-form-category-slug-cleaning-products-field']/following-sibling::label")
  end

  def radio_cleaning_services
    find(:xpath, "//input[@id='framework-support-form-category-slug-cleaning-services-field']/following-sibling::label")
  end

  def radio_ppe
    find(:xpath, "//input[@id='framework-support-form-category-slug-ppe-field']/following-sibling::label")
  end

  def radio_other
    find(:xpath, "//input[@id='framework-support-form-category-slug-other-field']/following-sibling::label")
  end

  def input_other
    find(:xpath, "//textarea[@id='framework-support-form-category-other-field']")
  end

  def button_continue
    find(:xpath, "//input[@value='Continue']")
  end
end
