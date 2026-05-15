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
    # Open up the "Office and education supplies" buying category
    fabs_home_comps.link_category_office_and_education_supplies.click
    expect(page).to have_current_path(%r{/categories/office-education-supplies}, url: true, wait: 10)
    expect(fabs_buying_category_comps.text_page_heading.text).to include("Office and education supplies")

    # Validate the breadcrumbs up to this point
    expect(fabs_buying_category_comps.breadcrumb_trail.map { |b| b.slice(:text, :href) }).to eq([
      { text: "Home", href: "/" },
    ])

    # Open up the "Musical instruments, equipment and technology" buying option
    fabs_buying_category_comps.link_buying_category_by_name("Musical instruments, equipment and technology").click
    expect(page).to have_current_path(%r{/categories/office-education-supplies/musical-instruments-equipment-and-technology}, url: true, wait: 10)
    expect(fabs_buying_option_comps.text_page_heading.text).to include("Musical instruments, equipment and technology")
  end

  def validate_the_breadcrumbs_on_the_buying_option_for_simple
    # Confirm were on the expected page
    expect(page).to have_current_path(%r{/categories/office-education-supplies/musical-instruments-equipment-and-technology}, url: true, wait: 10)
    expect(fabs_buying_option_comps.text_page_heading.text).to include("Musical instruments, equipment and technology")

    # Validate the breadcrumbs up to this point
    expect(fabs_buying_category_comps.breadcrumb_trail.map { |b| b.slice(:text, :href) }).to eq([
      { text: "Home", href: "/" },
      { text: "Office and education supplies", href: "/categories/office-education-supplies" },
    ])
  end

  def navigate_to_complex_buying_option_via_parent
    # "Education decarbonisation" is the example we will use, its in both the "Facilities management and estates" and "Energy" categories

    # Open up the Energy buying category
    fabs_home_comps.link_category_energy.click
    expect(page).to have_current_path(%r{/categories/energy}, url: true, wait: 10)
    expect(fabs_buying_category_comps.text_page_heading.text).to include("Energy")

    # Validate the breadcrumbs up to this point
    expect(fabs_buying_category_comps.breadcrumb_trail.map { |b| b.slice(:text, :href) }).to eq([
      { text: "Home", href: "/" },
    ])
    # Open up the Education decarbonisation buying option
    fabs_buying_category_comps.link_buying_category_by_name("Education decarbonisation").click
    expect(page).to have_current_path(%r{/categories/energy/education-decarbonisation}, url: true, wait: 10)
    expect(fabs_buying_option_comps.text_page_heading.text).to include("Education decarbonisation")
  end

  def validate_the_breadcrumbs_on_the_buying_option_via_parent
    # Confirm were on the expected page
    expect(page).to have_current_path(%r{/categories/energy/education-decarbonisation}, url: true, wait: 10)
    expect(fabs_buying_option_comps.text_page_heading.text).to include("Education decarbonisation")

    # Validate the parent breadcrumb is being shown ie Energy!
    expect(fabs_buying_category_comps.breadcrumb_trail.map { |b| b.slice(:text, :href) }).to eq([
      { text: "Home", href: "/" },
      { text: "Energy", href: "/categories/energy" },
    ])
  end

  def navigate_to_complex_buying_option_via_non_parent
    # Navigate back to the home page
    fabs_top_nav_comps.image_dfe_logo.click
    fabs_top_nav_comps.image_dfe_logo.click
    expect(page).to have_current_path(%r{/}, url: true, wait: 10)
    wait_for_element_to_include(fabs_home_comps.text_page_heading, "Get help buying for schools", timeout: 5)

    # Open up the Facilities management and estates buying category
    fabs_home_comps.link_category_facilities_management_and_estates.click
    expect(page).to have_current_path(%r{/categories/facilities-management-estates}, url: true, wait: 10)
    expect(fabs_buying_category_comps.text_page_heading.text).to include("Facilities management and estates")

    # Validate the breadcrumbs up to this point
    expect(fabs_buying_category_comps.breadcrumb_trail.map { |b| b.slice(:text, :href) }).to eq([
      { text: "Home", href: "/" },
    ])
    # Open up the Education decarbonisation buying option
    fabs_buying_category_comps.link_buying_category_by_name("Education decarbonisation").click
    expect(page).to have_current_path(%r{/categories/facilities-management-estates/education-decarbonisation}, url: true, wait: 10)
    expect(fabs_buying_option_comps.text_page_heading.text).to include("Education decarbonisation")
  end

  def validate_the_breadcrumbs_on_the_buying_option_via_non_parent
    # Confirm were on the expected page
    expect(page).to have_current_path(%r{/categories/facilities-management-estates/education-decarbonisation}, url: true, wait: 10)
    expect(fabs_buying_option_comps.text_page_heading.text).to include("Education decarbonisation")

    # Validate the parent breadcrumb is being shown ie Facilities management and estates!
    expect(fabs_buying_category_comps.breadcrumb_trail.map { |b| b.slice(:text, :href) }).to eq([
      { text: "Home", href: "/" },
      { text: "Facilities management and estates", href: "/categories/facilities-management-estates" },
    ])
  end
end
