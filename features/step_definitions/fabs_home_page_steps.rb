require_relative '../../pages/fabs_home_page_methods'

def fabs_home_page
  @fabs_home_page ||= FabsHomePageMethods.new
end

Given('we open and validate the fabs homepage') do
  fabs_home_page.open_fabs_homepage
  fabs_home_page.validate_homepage_loaded
end

Given('I search for {string} in the main search on the fabs homepage') do |term|
  fabs_home_page.search_for(term)
end
