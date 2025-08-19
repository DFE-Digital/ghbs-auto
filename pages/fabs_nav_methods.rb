require_relative './fabs_base_page'
require_relative '../helpers/url_nav_helpers'

class FabsNavMethods < FabsBasePage
  include UrlHelpers

  # --- Error pages ---

  def navigate_to_404_page
    go_to_fabs_path('/404')
    expect(fabs_404_comps.text_page_heading.text).to include('Page not found')
  end

  def navigate_to_500_page
    go_to_fabs_path('/500')
    expect(fabs_500_comps.text_page_heading.text).to include('Sorry, there is a problem with the service')
  end

  # --- Search / All buying options ---

  def navigate_to_search_page
    reset_to_homepage_via_logo
    fabs_home_page_comps.button_main_search.click
    expect(fabs_search_comps.text_page_heading.text).to include('Search Get help buying for schools')
  end

  def navigate_to_all_buying_options_page
    reset_to_homepage_via_logo
    fabs_home_page_comps.link_all_buying_options.click
    expect(fabs_home_page_comps.text_page_heading.text).to include('All buying options')
  end

  # --- Footer pages ---

  def navigate_to_accessibility_statement_page
    reset_to_homepage_via_logo
    fabs_footer_comps.link_accessibility_statement.click
    expect(fabs_access_statement_comps.text_page_heading.text).to include('Accessibility statement for Get help buying for schools')
  end

  def navigate_to_terms_and_conditions_page
    reset_to_homepage_via_logo
    fabs_footer_comps.link_terms_and_conditions.click
    expect(fabs_terms_and_conditions_comps.text_page_heading.text).to include('Terms and conditions')
  end

  # --- Category / option flows (WIP placeholders) ---
  def navigate_to_first_available_category_page
    # TODO: implement once locators/flow confirmed
  end

  def navigate_to_first_available_buying_option_page
    # TODO: implement once locators/flow confirmed
  end


  # --- Helpers ---
  def reset_to_homepage_via_logo
    fabs_top_nav_comps.image_dfe_logo.click
    expect(fabs_home_page_comps.text_page_heading.text).to include('Get help buying for schools')
  end

end
