# frozen_string_literal: true

class CmsFrameworksIndividualFrameworkComps < CmsBasePage
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

  def link_framework_created_see_details
    find(:xpath, "(//h2[contains(.,'Framework Created')])[1]/following-sibling::div//span[contains(.,'See details')]")
  end

  def text_framework_created_source
    find(:xpath, "(//h2[contains(.,'Framework Created')])[1]/following-sibling::div//tr/th[contains(.,'Source')]/following-sibling::td")
  end

  def text_framework_created_contentful_id
    find(:xpath, "(//h2[contains(.,'Framework Created')])[1]/following-sibling::div//tr/th[contains(.,'Contentful')]/following-sibling::td")
  end

end
