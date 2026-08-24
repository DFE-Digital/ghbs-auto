# frozen_string_literal: true

class RfhWhatTypeOfGoodsAndServicesComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def link_back
    find(:xpath, "//a[text()='Back']")
  end

  def radio_audits
    find(:xpath, "//input[@id='framework-support-form-category-slug-audits-field']/following-sibling::label")
  end

  def radio_buildings_and_site_maintenance
    find(:xpath, "//input[@id='framework-support-form-category-slug-buildings-and-site-maintenance-field']/following-sibling::label")
  end

  def radio_cleaning
    find(:xpath, "//input[@id='framework-support-form-category-slug-cleaning-field']/following-sibling::label")
  end

  def radio_consultancy
    find(:xpath, "//input[@id='framework-support-form-category-slug-consultancy-field']/following-sibling::label")
  end

  def radio_energy_and_utilities
    find(:xpath, "//input[@id='framework-support-form-category-slug-energy-and-utilities-field']/following-sibling::label")
  end

  def radio_financial_services
    find(:xpath, "//input[@id='framework-support-form-category-slug-financial-services-field']/following-sibling::label")
  end

  def radio_food_and_catering
    find(:xpath, "//input[@id='framework-support-form-category-slug-food-and-catering-field']/following-sibling::label")
  end

  def radio_furniture
    find(:xpath, "//input[@id='framework-support-form-category-slug-furniture-field']/following-sibling::label")
  end

  def radio_health_and_safety
    find(:xpath, "//input[@id='framework-support-form-category-slug-health-and-safety-field']/following-sibling::label")
  end

  def radio_human_resources_and_payroll
    find(:xpath, "//input[@id='framework-support-form-category-slug-human-resources-and-payroll-field']/following-sibling::label")
  end

  def radio_ict
    find(:xpath, "//input[@id='framework-support-form-category-slug-ict-field']/following-sibling::label")
  end

  def radio_leasing
    find(:xpath, "//input[@id='framework-support-form-category-slug-leasing-field']/following-sibling::label")
  end

  def radio_legal_services
    find(:xpath, "//input[@id='framework-support-form-category-slug-legal-services-field']/following-sibling::label")
  end

  def radio_school_and_education_supplies
    find(:xpath, "//input[@id='framework-support-form-category-slug-school-and-education-supplies-field']/following-sibling::label")
  end

  def radio_transport
    find(:xpath, "//input[@id='framework-support-form-category-slug-transport-field']/following-sibling::label")
  end

  def radio_im_buying_more_than_one_thing
    find(:xpath, "//input[@id='framework-support-form-category-slug-multiple-field']/following-sibling::label")
  end

  def button_continue
    find(:xpath, "//input[@value='Continue']")
  end
end
