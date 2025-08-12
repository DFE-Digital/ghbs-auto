require_relative '../helpers/wait_helpers'

class FabsHomePageComps
  include WaitHelpers

  def initialize(driver)
    @driver = driver
  end

  def tagline_heading
    wait_until_visible(:xpath, "//h1[contains(text(), 'Get help buying for schools')]")
  end

  def all_buying_options_link
    wait_until_visible(:xpath, "//a[contains(text(), 'Browse a list of all DfE-approved buying options')]")
  end

  def join_energy_for_schools_banner_link
    wait_until_visible(:xpath, "//a[contains(text(), 'Join Energy for Schools')]")
  end

  def main_search_input
    wait_until_visible(:xpath, "//input[@id = 'homepage-search-field']")

  end

  def main_search_button
    wait_until_visible(:xpath, "//input[@id = 'homepage-search-field']/following-sibling::button")
  end

end
