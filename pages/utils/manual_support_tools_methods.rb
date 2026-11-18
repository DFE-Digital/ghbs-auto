# frozen_string_literal: true

require "pages/shared/shared_global_base_page"
require "helpers/validation_helpers"
require "components/fabs/fabs_all_buying_options_comps"

class ManualSupportToolsMethods < SharedGlobalMethodsBasePage
  include ValidationHelpers
  include SharedFabsComps

  def log_urls_from_all_buying_options
    # Navigate to the "All buying options" screen
    visit SECRETS["all_buying_options_url"]
    expect(page).to have_current_path(%r{/solutions}, url: true, wait: 10)

    # List all of the urls for the solutions in the console
    print_links_from_area(fabs_all_buying_options_comps.xpath_container_of_all_links)
  end

private

  def print_links_from_area(area_xpath)
    area = find(:xpath, area_xpath)

    links = area.all(:xpath, ".//a[@href]", minimum: 0)

    puts "| Page | URL |"
    puts "|---|---|"

    links.each do |link|
      puts "| #{link.text.strip} | #{link[:href]} |"
    end
  end
end
