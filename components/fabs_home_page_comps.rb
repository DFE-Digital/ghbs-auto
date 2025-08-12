class FabsHomePageComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def input_search_field
    find(:xpath, "//input[@id='homepage-search-field']")
  end

  def button_main_search
    find(:xpath, "//input[@id = 'homepage-search-field']/following-sibling::button")
  end


end
