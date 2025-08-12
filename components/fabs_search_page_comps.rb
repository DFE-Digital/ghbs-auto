require_relative '../helpers/wait_helpers'

class FabsSearchPageComps
  include WaitHelpers

  def initialize(driver)
    @driver = driver
  end

  def tagline_heading
    wait_until_visible(:xpath, "//h1[contains(text(), 'Search Get help buying for schools')]")
  end

  def search_result_title(search_title)
    wait_until_clickable(:xpath, "//a[contains(text(), '#{search_title}')]")
  end


end
