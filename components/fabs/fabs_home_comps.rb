# frozen_string_literal: true

class FabsHomeComps
  include Capybara::DSL

  # Text
  def text_page_heading
    find(:xpath, "//h1")
  end

  # Inputs
  def input_search_field
    find(:xpath, "//form[@id='homepage-search']//input")
  end

  # Buttons
  def button_main_search
    find(:xpath, "//form[@id='homepage-search']//following-sibling::button")
  end

  # Links
  def link_all_buying_options
    find(:xpath, "//a[text()='Browse a list of all DfE-approved buying options']")
  end

  def link_category_energy_and_utilities
    find(:xpath, "//a[text()='Energy and utilities']")
  end

  def link_category_buildings_and_maintenance
    find(:xpath, "//a[text()='Buildings and maintenance']")
  end

  def link_category_it
    find(:xpath, "//a[text()='IT']")
  end

  def link_category_classroom_curriculum_and_office_supplies
    find(:xpath, "//a[text()='Classroom, curriculum and office supplies']")
  end

  def link_category_professional_services
    find(:xpath, "//a[text()='Professional services']")
  end

  def link_category_recruitment_hr_and_training
    find(:xpath, "//a[text()='Recruitment, HR and training']")
  end

  def link_category_finance_legal_and_insurance
    find(:xpath, "//a[text()='Finance, legal and insurance']")
  end

  def link_about_this_service
    find(:xpath, "//a[contains(.,'About this service')]")
  end

  def link_expanded_top_menu_about_this_service
    find(:xpath, "//h3[contains(.,'Guidance and support')]/following-sibling::ul//a[text()='About our service']")
  end

  def link_agency_supply_staff
    find(:xpath, "//a[contains(.,'Agency supply staff')]")
  end

  def link_energy_for_schools
    find(:xpath, "//a[contains(.,'Energy for schools')]")
  end

  def button_get_expert_buying_help
    find(:xpath, "//a[text()='Get expert buying help']")
  end
end
