# frozen_string_literal: true

require "pages/fabs/fabs_base_page"
require "components/fabs/fabs_home_comps"
require "components/fabs/fabs_buying_category_comps"
require "components/fabs/fabs_buying_option_comps"
require "components/fabs/fabs_top_nav_comps"
require "helpers/url_nav_helpers"
require "helpers/validation_helpers"

class FabsBreadcrumbMethods < FabsBasePage
  include UrlHelpers
  include ValidationHelpers

  def navigate_to_a_simple_buying_option_via_buying_category
    # Open up the "Classroom, curriculum and office supplies" buying category
    fabs_home_comps.link_category_classroom_curriculum_and_office_supplies.click
    expect(page).to have_current_path(%r{/categories/classroom-curriculum-office-supplies}, url: true, wait: 10)
    expect(fabs_buying_category_comps.text_page_heading.text).to include("Classroom, curriculum and office supplies")

    # Validate the breadcrumbs up to this point
    expect(fabs_buying_category_comps.breadcrumb_trail.map { |b| b.slice(:text, :href) }).to eq([
      { text: "Home", href: "/" },
    ])

    # Open up the "Musical instruments, equipment and technology" buying option
    fabs_buying_category_comps.link_buying_category_by_name("Musical instruments, equipment and technology").click
    expect(page).to have_current_path(%r{/categories/classroom-curriculum-office-supplies/musical-instruments-equipment-and-technology}, url: true, wait: 10)
    expect(fabs_buying_option_comps.text_page_heading.text).to include("Musical instruments, equipment and technology")
  end

  def validate_the_breadcrumbs_on_the_buying_option_for_simple
    # Confirm were on the expected page
    expect(page).to have_current_path(%r{/categories/classroom-curriculum-office-supplies/musical-instruments-equipment-and-technology}, url: true, wait: 10)
    expect(fabs_buying_option_comps.text_page_heading.text).to include("Musical instruments, equipment and technology")

    # Validate the breadcrumbs up to this point
    expect(fabs_buying_category_comps.breadcrumb_trail.map { |b| b.slice(:text, :href) }).to eq([
      { text: "Home", href: "/" },
      { text: "Classroom, curriculum and office supplies", href: "/categories/classroom-curriculum-office-supplies" },
    ])
  end

  def navigate_to_complex_buying_option_via_parent
    # "Education decarbonisation" is the example we will use, its in both the "Facilities management and estates" and "Energy" categories

    # Open up the "Energy and utilities" buying category
    fabs_home_comps.link_category_energy_and_utilities.click
    expect(page).to have_current_path(%r{/categories/energy-utilities}, url: true, wait: 10)
    expect(fabs_buying_category_comps.text_page_heading.text).to include("Energy and utilities")

    # Validate the breadcrumbs up to this point
    expect(fabs_buying_category_comps.breadcrumb_trail.map { |b| b.slice(:text, :href) }).to eq([
      { text: "Home", href: "/" },
    ])
    # Open up the Education decarbonisation buying option
    fabs_buying_category_comps.link_buying_category_by_name("Education decarbonisation").click
    expect(page).to have_current_path(%r{/categories/energy-utilities/education-decarbonisation}, url: true, wait: 10)
    expect(fabs_buying_option_comps.text_page_heading.text).to include("Education decarbonisation")
  end

  def validate_the_breadcrumbs_on_the_buying_option_via_parent
    # Confirm were on the expected page
    expect(page).to have_current_path(%r{/categories/energy-utilities/education-decarbonisation}, url: true, wait: 10)
    expect(fabs_buying_option_comps.text_page_heading.text).to include("Education decarbonisation")

    # Validate the parent breadcrumb is being shown ie Energy!
    expect(fabs_buying_category_comps.breadcrumb_trail.map { |b| b.slice(:text, :href) }).to eq([
      { text: "Home", href: "/" },
      { text: "Energy and utilities", href: "/categories/energy-utilities" },
    ])
  end

  def navigate_to_complex_buying_option_via_non_parent
    nav_back_to_the_homepage

    # Open up the "Buildings and maintenance" buying category
    fabs_home_comps.link_category_buildings_and_maintenance.click
    expect(page).to have_current_path(%r{/categories/buildings-maintenance}, url: true, wait: 10)
    expect(fabs_buying_category_comps.text_page_heading.text).to include("Buildings and maintenance")

    # Validate the breadcrumbs up to this point
    expect(fabs_buying_category_comps.breadcrumb_trail.map { |b| b.slice(:text, :href) }).to eq([
      { text: "Home", href: "/" },
    ])

    # Open up the Outdoor sports surfaces and activity equipment buying option
    fabs_buying_category_comps.link_buying_category_by_name("Outdoor sports surfaces and activity equipment").click
    expect(page).to have_current_path(%r{/categories/buildings-maintenance/outdoor-sports-surfaces-and-activity-equipment}, url: true, wait: 10)
    expect(fabs_buying_option_comps.text_page_heading.text).to include("Outdoor sports surfaces and activity equipment")

    # Validate the breadcrumbs up to this point
    expect(fabs_buying_category_comps.breadcrumb_trail.map { |b| b.slice(:text, :href) }).to eq([
      { text: "Home", href: "/" },
      { text: "Buildings and maintenance", href: "/categories/buildings-maintenance" },
    ])

    nav_back_to_the_homepage

    # Open up the "Classroom, curriculum and office supplies" buying category
    fabs_home_comps.link_category_classroom_curriculum_and_office_supplies.click
    expect(page).to have_current_path(%r{/categories/classroom-curriculum-office-supplies}, url: true, wait: 10)
    expect(fabs_buying_category_comps.text_page_heading.text).to include("Classroom, curriculum and office supplies")

    # Validate the breadcrumbs up to this point
    expect(fabs_buying_category_comps.breadcrumb_trail.map { |b| b.slice(:text, :href) }).to eq([
      { text: "Home", href: "/" },
    ])
  end

  def validate_the_breadcrumbs_on_the_buying_option_via_non_parent
    # Open up the Outdoor sports surfaces and activity equipment buying option
    fabs_buying_category_comps.link_buying_category_by_name("Outdoor sports surfaces and activity equipment").click
    expect(page).to have_current_path(%r{/categories/classroom-curriculum-office-supplies/outdoor-sports-surfaces-and-activity-equipment}, url: true, wait: 10)
    expect(fabs_buying_option_comps.text_page_heading.text).to include("Outdoor sports surfaces and activity equipment")

    # Validate the breadcrumbs up to this point
    expect(fabs_buying_category_comps.breadcrumb_trail.map { |b| b.slice(:text, :href) }).to eq([
      { text: "Home", href: "/" },
      { text: "Classroom, curriculum and office supplies", href: "/categories/classroom-curriculum-office-supplies" },
    ])
  end

  def nav_back_to_the_homepage
    # Navigate back to the home page
    fabs_top_nav_comps.image_dfe_logo.click
    fabs_top_nav_comps.image_dfe_logo.click
    expect(page).to have_current_path(%r{/}, url: true, wait: 10)
    wait_for_element_to_include(fabs_home_comps.text_page_heading, "Get help buying for schools", timeout: 5)
  end
end
