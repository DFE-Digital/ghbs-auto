# frozen_string_literal: true

class CmsSearchResultsPageComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def link_case_number(case_number)
    find(:xpath, "//a[contains(.,'#{case_number}')]")
  end

  def link_org_based_on_case_number(case_number)
    find(:xpath, "//a[contains(.,'#{case_number}')]/ancestor::td/following-sibling::td[1]/div/a")
  end

  def link_first_case_number
    find(:xpath, "//tr[1]/td[1]/a")
  end

  def link_all_orgs_in_list
    all(:xpath, "//tbody/tr/td/div/a", wait: 10)
  end

  def text_number_of_results
    find(:xpath, "//h1[contains(.,'Search results')]/following-sibling::p")
  end

  def dropdown_filer_by_status(option)
    find(:xpath, "//select[@id='search-case-form-state-field']/option[text()='#{option}']")
  end

  def button_apply_filter
    find(:xpath, "//input[@value='Apply filter']")
  end

  def button_clear_filter
    find(:xpath, "//a[text()='Clear filters']")
  end

  def link_case_number_with_open_status
    find(:xpath, "//strong[contains(.,'Open')]/ancestor::tr/td[1]/a")
  end

  def links_case_number_with_open_status(minimum: 0)
    all(:xpath, "//strong[normalize-space()='Open']/ancestor::tr/td[1]//a", minimum: minimum)
  end

  def link_case_number_with_on_hold_status
    find(:xpath, "//strong[contains(.,'On Hold')]/ancestor::tr/td[1]/a")
  end

  def links_case_number_with_on_hold_status(minimum: 0)
    all(:xpath, "//strong[normalize-space()='On Hold']/ancestor::tr/td[1]//a", minimum: minimum)
  end
end
