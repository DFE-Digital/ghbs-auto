# frozen_string_literal: true

class FabsHomePageComps
  include Capybara::DSL

  # Text
  def text_page_heading
    find(:xpath, "//h1")
  end

  # Inputs
  def input_search_field
    find(:xpath, "//input[@id='homepage-search-field']")
  end

  # Buttons
  def button_main_search
    find(:xpath, "//input[@id = 'homepage-search-field']/following-sibling::button")
  end

  # Links
  def link_all_buying_options
    find(:xpath, "//a[text()='Browse a list of all DfE-approved buying options']")
  end
end
