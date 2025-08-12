require_relative '../components/fabs_home_page_comps'
require_relative '../components/fabs_search_page_comps'

class FabsHomePage
  def initialize(driver, secrets)
    @driver = driver
    @secrets = secrets
    @home_page_comps = FabsHomePageComps.new(@driver)
    @search_page_comps = FabsSearchPageComps.new(@driver)
  end

  def open_fabs_homepage
    homepage_url = @secrets["staging_fabs_homepage_url"]
    raise "Missing staging_fabs_homepage_url in secrets!" unless homepage_url.is_a?(String) && !homepage_url.strip.empty?

    puts "[DEBUG] Navigating to: #{homepage_url}"
    @driver.navigate.to homepage_url
  end

  def validate_fabs_homepage_is_loaded
    actual_text = @home_page_comps.tagline_heading.text
    expected_text = "Get help buying for schools"
    raise "Expected tagline '#{expected_text}', but got '#{actual_text}'" unless actual_text == expected_text
  end

  def run_main_search(expected_search_term)
    # add content and run the search
    @home_page_comps.main_search_input.send_keys(expected_search_term)
    @home_page_comps.main_search_button.click
    # confirm the search page has loaded
    actual_text = @search_page_comps.tagline_heading.text

    expected_text = "Search Get help buying for schools"
    raise "Expected tagline '#{expected_text}', but got '#{actual_text}'" unless actual_text == expected_text
  end

end
