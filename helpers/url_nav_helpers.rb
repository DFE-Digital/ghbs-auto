module UrlHelpers
  include Capybara::DSL

  def go_to_fabs_path(path)
    # allows you to go to places directly with the fabs url that you cant otherwise reach like /404 or /500 etc
    visit("#{SECRETS['staging_fabs_homepage_url']}#{path}")
  end

end
