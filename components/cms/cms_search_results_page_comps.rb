# frozen_string_literal: true

class CmsSearchResultsPageComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def link_case_number(case_number)
    find(:xpath, "//a[contains(.,'#{case_number}')]")
  end
end
