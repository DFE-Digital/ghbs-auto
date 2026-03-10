# frozen_string_literal: true

require "pages/fabs/fabs_base_page"
require "helpers/url_nav_helpers"
require "helpers/validation_helpers"
require "components/fabs/fabs_404_comps"
require "components/fabs/fabs_500_comps"
require "components/fabs/fabs_search_comps"
require "components/fabs/fabs_home_comps"
require "components/fabs/fabs_all_buying_options_comps"
require "components/fabs/fabs_footer_nav_comps"
require "components/fabs/fabs_accessibility_statement_comps"
require "components/fabs/fabs_terms_and_conditions_comps"
require "components/fabs/fabs_buying_category_comps"
require "components/fabs/fabs_buying_option_comps"
require "components/energy/pre_login/energy_before_you_start_comps"

class FabsNavMethods < FabsBasePage
  include UrlHelpers
  include ValidationHelpers

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
    fabs_home_comps.button_main_search.click
    expect(page).to have_current_path(%r{/search}, url: true, wait: 10)
    expect(fabs_search_comps.text_page_heading.text).to include("Search Get help buying for schools")
    axe_check! if FlagsGlobalConfig.axe_enabled?
  end

  def navigate_to_all_buying_options_page
    reset_to_homepage_via_logo
    fabs_home_comps.link_all_buying_options.click
    expect(page).to have_current_path(%r{/solutions}, url: true, wait: 10)
    expect(fabs_all_buying_options_comps.text_page_heading.text).to include("All buying options")
    axe_check! if FlagsGlobalConfig.axe_enabled?
  end

  # --- About this service page ---

  def navigate_to_about_this_service
    reset_to_homepage_via_logo
    fabs_home_comps.link_about_this_service.click
    expect(page).to have_current_path(%r{/about-this-service}, url: true, wait: 10)
    expect(fabs_all_buying_options_comps.text_page_heading.text).to include("About this service Request for help")
    axe_check! if FlagsGlobalConfig.axe_enabled?
  end

  # DfE energy for schools
  def navigate_to_energy_for_schools_via_category
    reset_to_homepage_via_logo

    # open energy category
    fabs_home_comps.link_category_energy.click
    expect(page).to have_current_path(%r{/categories/energy}, url: true, wait: 10)
    expect(fabs_buying_category_comps.text_page_heading.text).to include("Energy")
    axe_check! if FlagsGlobalConfig.axe_enabled?

    # select and open DfE energy for Schools solution
    fabs_buying_category_comps.link_buying_category_by_name("DfE Energy for Schools").click
    expect(page).to have_current_path(%r{/categories/energy/energy-for-schools}, url: true, wait: 10)
    expect(fabs_buying_option_comps.text_page_heading.text).to include("DfE Energy for Schools")

    # use the cta to navigate to the before you start page of the energy flow
    fabs_buying_option_comps.button_cta_join_energy_for_schools.click

    # At this point we have a new window open and need to switch context to it
    switch_to_window windows.last
    expect(page).to have_current_path(%r{/energy/before-you-start}, url: true, wait: 10)
    wait_for_element_to_include(energy_before_you_start_comps.text_page_heading, "Energy for Schools", timeout: 5)
    wait_for_element_to_include(energy_before_you_start_comps.text_page_sub_heading, "Before you start", timeout: 5)
  end

  # --- Footer pages ---

  def navigate_to_accessibility_statement_page
    reset_to_homepage_via_logo
    fabs_footer_nav_comps.link_accessibility_statement.click
    expect(page).to have_current_path(%r{/accessibility-statement}, url: true, wait: 10)
    expect(fabs_accessibility_statement_comps.text_page_heading.text).to include("Accessibility statement for Get help buying for schools")
    axe_check! if FlagsGlobalConfig.axe_enabled?
  end

  def navigate_to_terms_and_conditions_page
    reset_to_homepage_via_logo
    fabs_footer_nav_comps.link_terms_and_conditions.click
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
    expect(fabs_home_comps.text_page_heading.text).to include("Get help buying for schools")
    axe_check! if FlagsGlobalConfig.axe_enabled?
  end
end
