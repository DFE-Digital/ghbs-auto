# frozen_string_literal: true

class CmsFindACasePageComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1/label")
  end

  def input_search_case_info
    find(:xpath, "//input[@id='search-case-form-search-term-field']")
  end

  def button_search
    find(:xpath, "//input[@role='button' and @value='Search']")
  end
end
