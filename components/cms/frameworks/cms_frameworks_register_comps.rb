# frozen_string_literal: true

class CmsFrameworksRegisterComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//a[text()='Frameworks Register']")
  end

  def input_search
    find(:xpath, "//input[@id='frameworks-filter-omnisearch-field']")
  end

  def link_internal_framework_ref(framework_name)
    find(:xpath, "//dd[text()='#{framework_name}']/ancestor::div/preceding-sibling::div/dt[text()='Framework Ref']/following-sibling::dd/a")
  end

  def checkbox_status_dfe_approved
    find(:xpath, "//label[text()='DfE approved']")
  end

  def checkbox_status_cab_approved
    find(:xpath, "//label[text()='CAB approved']")
  end

  def checkbox_status_evaluating
    find(:xpath, "//label[text()='Evaluating']")
  end

  def checkbox_status_expired
    find(:xpath, "//label[text()='Expired']")
  end

  def checkbox_status_not_approved
    find(:xpath, "//label[text()='Not approved']")
  end

  def checkbox_status_archived
    find(:xpath, "//label[text()='Archived']")
  end
end
