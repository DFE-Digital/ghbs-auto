# frozen_string_literal: true

require "pages/fabs/fabs_base_page"
require "components/fabs/fabs_home_comps"
require "components/fabs/fabs_buying_category_comps"
require "components/fabs/fabs_buying_option_comps"
require "helpers/url_nav_helpers"

class FabsBreadcrumbMethods < FabsBasePage
  include UrlHelpers

  # --- Error pages ---

  def navigate_to_a_simple_buying_option_via_buying_category
    # Open up the Recruitment, HR and training buying category
    fabs_home_comps.link_category_recruitment_hr_and_training.click
    expect(page).to have_current_path(%r{/categories/recruitment-hr-training}, url: true, wait: 10)
    expect(fabs_buying_category_comps.text_page_heading.text).to include("Recruitment, HR and training")

    # Validate the breadcrumbs up to this point
    expect(fabs_buying_category_comps.breadcrumb_trail.map { |b| b.slice(:text, :href) }).to eq([
      { text: "Home", href: "/" },
    ])
    # Open up the Temporary and permanent staffing buying option
    fabs_buying_category_comps.link_buying_category_by_name("Temporary and permanent staffing").click
    expect(page).to have_current_path(%r{/categories/recruitment-hr-training/temporary-and-permanent-staffing}, url: true, wait: 10)
    expect(fabs_buying_option_comps.text_page_heading.text).to include("Temporary and permanent staffing")
  end

  def validate_the_breadcrumbs_on_the_buying_option_for_simple
    # Confirm were on the expected page
    expect(page).to have_current_path(%r{/categories/recruitment-hr-training/temporary-and-permanent-staffing}, url: true, wait: 10)
    expect(fabs_buying_option_comps.text_page_heading.text).to include("Temporary and permanent staffing")

    # Validate the breadcrumbs up to this point
    expect(fabs_buying_category_comps.breadcrumb_trail.map { |b| b.slice(:text, :href) }).to eq([
      { text: "Home", href: "/" },
      { text: "Recruitment, HR and training", href: "/categories/recruitment-hr-training" },
    ])
  end

end
