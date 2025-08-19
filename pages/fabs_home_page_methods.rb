require 'pages/fabs_base_page'
require 'components/fabs_home_page_comps'
require 'components/fabs_search_page_comps'

class FabsHomePageMethods < FabsBasePage
  def open_fabs_homepage
    visit SECRETS['staging_fabs_homepage_url']
  end

  def validate_homepage_loaded
    expect(fabs_home_page_comps.text_page_heading.text)
      .to include("Get help buying for schools")
  end

  def search_for(term)
    # Search the term
    fabs_home_page_comps.input_search_field.set(term)
    fabs_home_page_comps.button_main_search.click

    # confirm the page load
    expect(fabs_search_comps.text_page_heading.text)
      .to include("Search Get help buying for schools")
  end
end

