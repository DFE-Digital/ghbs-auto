Given('we open and validate the fabs homepage') do
  home_page_methods.open_fabs_homepage
  home_page_methods.validate_homepage_loaded
end

Given('I search for {string} in the main search on the fabs homepage') do |term|
  home_page_methods.search_for(term)
end