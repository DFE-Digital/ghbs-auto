# frozen_string_literal: true

require "pages/fabs/fabs_base_page"
require "components/fabs/fabs_home_comps"
require "components/fabs/fabs_search_comps"
require "helpers/validation_helpers"

class FabsHomePageMethods < FabsBasePage
  include ValidationHelpers
  def open_fabs_homepage
    visit SECRETS["staging_fabs_homepage_url"]
  end

  def validate_homepage_loaded
    wait_for_element_to_include(fabs_home_comps.text_page_heading, "Get help buying for schools", timeout: 5)
  end

  def search_for(term)
    # Search the term
    fabs_home_comps.input_search_field.set(term)
    fabs_home_comps.button_main_search.click

    # confirm the page load
    wait_for_element_to_include(fabs_search_comps.text_page_heading, "Search Get help buying for schools", timeout: 5)
  end
end
