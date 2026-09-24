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

  # DfE featured tiles
  def link_dfe_featured_get_help_running_my_procurement
    find(:xpath, "//a[text()='Get help running my procurement']")
  end

  def link_dfe_featured_browse_buying_options
    find(:xpath, "//a[text()='Browse buying options']")
  end

  def link_dfe_featured_access_dfe_led_offers
    find(:xpath, "//a[text()='Access DfE-led offers']")
  end

  # Popular tiles
  # TODO: html getting changed so need to update when we get the new release on dev
  def link_popular_hire_supply_staff
    find(:xpath, "TBC")
  end

  def link_popular_buy_school_essentials_from_catalogues
    find(:xpath, "TBC")
  end

  def link_popular_get_insurance_through_dfe
    find(:xpath, "TBC")
  end

  def link_popular_compare_savings_accounts
    find(:xpath, "TBC")
  end

  def link_popular_browse_maintenance_services
    find(:xpath, "TBC")
  end

  def link_popular_join_the_energy_for_schools_deal
    find(:xpath, "TBC")
  end

  # Browse by category
  def link_category_buildings_and_maintenance
    find(:xpath, "//div[@class='homepage-category-list']//a[text()='Buildings and maintenance']")
  end

  def link_category_catering
    find(:xpath, "//div[@class='homepage-category-list']//a[text()='Catering']")
  end

  def link_category_classroom_curriculum_and_office_supplies
    find(:xpath, "//div[@class='homepage-category-list']//a[text()='Classroom, curriculum and office supplies']")
  end

  def link_category_energy_and_utilities
    find(:xpath, "//div[@class='homepage-category-list']//a[text()='Energy and utilities']")
  end

  def link_category_finance_legal_and_insurance
    find(:xpath, "//div[@class='homepage-category-list']//a[text()='Finance, legal and insurance']")
  end

  def link_category_hr_people_and_professional_services
    find(:xpath, "//div[@class='homepage-category-list']//a[text()='HR, people and professional services']")
  end

  def link_category_ict_and_business_systems
    find(:xpath, "//div[@class='homepage-category-list']//a[text()='ICT and business systems']")
  end

  # Mega Menu
  def link_mega_menu_about_our_service
    find(:xpath, "//h3[contains(.,'Guidance and support')]/following-sibling::ul//a[text()='About our service']")
  end

  # Request Help
  def dropdown_start_your_request
    find(:xpath, "//b[text()='Start your request']")
  end

  def link_short_form_rfh
    find(:xpath, "//a[text()='short form']")
  end

  def link_all_buying_options
    find(:xpath, "//a[text()='Browse a list of all DfE-approved buying options']")
  end
end
