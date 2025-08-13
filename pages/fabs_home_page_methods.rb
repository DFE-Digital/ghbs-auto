require 'capybara/dsl'
require 'rspec/expectations'

require_relative '../components/fabs_home_page_comps'
require_relative '../components/fabs_search_page_comps'

class FabsHomePageMethods
  include Capybara::DSL
  include RSpec::Matchers

  def initialize
    @home_page_comps = FabsHomePageComps.new
    @search_page_comps = FabsSearchPageComps.new
  end

  def open_fabs_homepage()
    visit SECRETS['staging_fabs_homepage_url']
  end

  def validate_homepage_loaded
    expect(@home_page_comps.text_page_heading.text).to include("Get help buying for schools")
  end

  def search_for(term)
    # Search the term
    @home_page_comps.input_search_field.set(term)
    @home_page_comps.button_main_search.click

    # confirm the page load
    expect(@search_page_comps.text_page_heading.text).to include("Search Get help buying for schools")

  end
end
