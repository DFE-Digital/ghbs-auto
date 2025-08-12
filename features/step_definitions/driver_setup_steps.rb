require_relative '../../pages/fabs_home_page_methods'

def fabs_homepage
  @fabs_homepage ||= FabsHomePage.new(@driver, SECRETS)
end

Given('we open and validate the fabs homepage') do
  fabs_homepage.open_fabs_homepage
  fabs_homepage.validate_fabs_homepage_is_loaded
end

