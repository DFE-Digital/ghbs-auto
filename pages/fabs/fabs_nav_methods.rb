# frozen_string_literal: true

require "pages/fabs/fabs_base_page"
require "helpers/url_nav_helpers"

class FabsNavMethods < FabsBasePage
  include UrlHelpers

  # --- Error pages ---

  def navigate_to_404_page
    go_to_fabs_path("/404")
    expect(page).to have_current_path(%r{/404}, url: true, wait: 10)
    expect(fabs_404_comps.text_page_heading.text).to include("Page not found")
    axe_check! if FlagsGlobalConfig.axe_enabled?
  end

  def navigate_to_500_page
    go_to_fabs_path("/500")
    expect(page).to have_current_path(%r{/500}, url: true, wait: 10)
    expect(fabs_500_comps.text_page_heading.text).to include("Sorry, there is a problem with the service")
    axe_check! if FlagsGlobalConfig.axe_enabled?
  end

  # --- Search / All buying options ---

  def navigate_to_search_page
    reset_to_homepage_via_logo
    fabs_home_page_comps.button_main_search.click
    expect(page).to have_current_path(%r{/search}, url: true, wait: 10)
    expect(fabs_search_comps.text_page_heading.text).to include("Search Get help buying for schools")
    axe_check! if FlagsGlobalConfig.axe_enabled?
  end

  def navigate_to_all_buying_options_page
    reset_to_homepage_via_logo
    fabs_home_page_comps.link_all_buying_options.click
    expect(page).to have_current_path(%r{/solutions}, url: true, wait: 10)
    expect(fabs_home_page_comps.text_page_heading.text).to include("All buying options")
    axe_check! if FlagsGlobalConfig.axe_enabled?
  end

  # --- Footer pages ---

  def navigate_to_accessibility_statement_page
    reset_to_homepage_via_logo
    fabs_footer_comps.link_accessibility_statement.click
    expect(page).to have_current_path(%r{/accessibility-statement}, url: true, wait: 10)
    expect(fabs_access_statement_comps.text_page_heading.text).to include("Accessibility statement for Get help buying for schools")
    axe_check! if FlagsGlobalConfig.axe_enabled?
  end

  def navigate_to_terms_and_conditions_page
    reset_to_homepage_via_logo
    fabs_footer_comps.link_terms_and_conditions.click
    expect(page).to have_current_path(%r{/terms-and-conditions}, url: true, wait: 10)
    expect(fabs_terms_and_conditions_comps.text_page_heading.text).to include("Terms and conditions")
    axe_check! if FlagsGlobalConfig.axe_enabled?
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
    expect(page).to have_current_path(%r{/}, url: true, wait: 10)
    expect(fabs_home_page_comps.text_page_heading.text).to include("Get help buying for schools")
    axe_check! if FlagsGlobalConfig.axe_enabled?
  end
end
