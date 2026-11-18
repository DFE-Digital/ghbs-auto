# frozen_string_literal: true

class FabsTopNavComps
  include Capybara::DSL

  def image_dfe_logo
    find(:xpath, "//img[@alt='Department for Education']")
  end

  # Top Nav Search
  def button_search
    find(:xpath, "//button[@id='super-search-menu-toggle']")
  end

  def input_top_search
    find(:xpath, "//input[@type='search' and @title='Search']")
  end

  def button_top_search
    find(:xpath, "//button[@type='submit' and @enterkeyhint='search']")
  end
end
