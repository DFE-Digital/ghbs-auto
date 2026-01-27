# frozen_string_literal: true

class CmsFrameworksIndividualFrameworkComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def input_search
    find(:xpath, "//input[@id='frameworks-filter-omnisearch-field']")
  end

  def text_internal_framework_ref
    find(:xpath, "//span[contains(.,'[F')]")
  end

  def text_framework_status
    find(:xpath, "//h1/following-sibling::p/strong")
  end

  def text_latest_updated_activity_time
    find(:xpath, "(//h2[contains(.,'Framework Updated')])[1]/following-sibling::p[contains(.,'by Admin tool')]/following-sibling::p/time")
  end

  def link_latest_updated_activity_see_details
    find(:xpath, "(//h2[contains(.,'Framework Updated')])[1]/following-sibling::div//span[contains(.,'See details')]")
  end

  def link_add_categories
    find(:xpath, "//a[text()='Add Categories']")
  end

  def add_categories_visible?
    has_selector?(:xpath, "//a[normalize-space()='Add Categories']", wait: 2)
  end

  def link_change_categories
    find(:xpath, "//dt[text()='Categories']/following-sibling::dd[2]/a[text()='Change']")
  end

  def change_categories_visible?
    has_selector?(:xpath, "//dt[text()='Categories']/following-sibling::dd[2]/a[text()='Change']", wait: 2)
  end

  def text_framework_updated_name
    find(:xpath, "(//h2[contains(.,'Framework Updated')])[1]/following-sibling::div//tr/th[contains(.,'Name')]/following-sibling::td")
  end

  def text_applied_category_name(cat_name)
    find(:xpath, "//dt[text()='Categories']/following-sibling::dd[1][contains(.,'#{cat_name}')]")
  end

  def text_framework_updated_description
    find(:xpath, "(//h2[contains(.,'Framework Updated')])[1]/following-sibling::div//tr/th[contains(.,'Description')]/following-sibling::td")
  end

  def text_framework_updated_provider_reference
    find(:xpath, "(//h2[contains(.,'Framework Updated')])[1]/following-sibling::div//tr/th[contains(.,'Provider reference')]/following-sibling::td")
  end

  def link_framework_created_see_details
    find(:xpath, "(//h2[contains(.,'Framework Created')])[1]/following-sibling::div//span[contains(.,'See details')]")
  end

  def link_framework_created_see_details_optional
    first(:xpath, "(//h2[contains(.,'Framework Created')])[1]/following-sibling::div//span[contains(.,'See details')]", minimum: 0)
  end

  def text_framework_created_source
    find(:xpath, "(//h2[contains(.,'Framework Created')])[1]/following-sibling::div//tr/th[contains(.,'Source')]/following-sibling::td")
  end

  def text_framework_created_contentful_id
    find(:xpath, "(//h2[contains(.,'Framework Created')])[1]/following-sibling::div//tr/th[contains(.,'Contentful')]/following-sibling::td")
  end

  def link_pagination_next
    find(:xpath, "//a[@aria-label='Next page']")
  end

  def link_pagination_results
    find(:xpath, "//div[@class='pagination__results']")
  end
end
