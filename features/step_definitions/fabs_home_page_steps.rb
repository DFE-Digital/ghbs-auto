require_relative '../../pages/fabs_home_page_methods'

def fabs_homepage
  @home_page ||= FabsHomePage.new(@driver, SECRETS)
end

Given('I search for {string} in to the main search on the fabs homepage') do |search_term|
  fabs_homepage.run_main_search(search_term)
end
