require_relative '../../pages/fabs_search_page_methods'

def fabs_search_page
  @search_page ||= FabsSearchPage.new(@driver, SECRETS)
end

Then('I am shown the resulting buying options') do
  fabs_search_page.search_result_for_laptop_check
end

