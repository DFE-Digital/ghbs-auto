# frozen_string_literal: true

class FabsHomeComps
  include Capybara::DSL

  # Text
  def text_page_heading
    find(:xpath, "//h1")
  end

  # Inputs
  def input_search_field
    find(:xpath, "//input[@id='homepage-search-field']")
  end

  # Buttons
  def button_main_search
    find(:xpath, "//input[@id = 'homepage-search-field']/following-sibling::button")
  end

  # Links
  def link_all_buying_options
    find(:xpath, "//a[text()='Browse a list of all DfE-approved buying options']")
  end

  def link_category_banking_and_finance
    find(:xpath, "//a[text()='Banking and finance']")
  end

  def link_category_energy
    find(:xpath, "//a[text()='Energy']")
  end

  def link_category_facilities_management_and_estates
    find(:xpath, "//a[text()='Facilities management and estates']")
  end

  def link_category_it
    find(:xpath, "//a[text()='IT']")
  end

  def link_category_office_and_education_supplies
    find(:xpath, "//a[text()='Office and education supplies']")
  end

  def link_category_professional_services
    find(:xpath, "//a[text()='Professional services']")
  end

  def link_category_recruitment_hr_and_training
    find(:xpath, "//a[text()='Recruitment, HR and training']")
  end
end
