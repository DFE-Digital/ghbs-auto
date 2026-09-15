# frozen_string_literal: true

class FabsAllBuyingOptionsComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def xpath_container_of_all_links
    "//div[@class='govuk-grid-row']/div[2]"
  end
end
