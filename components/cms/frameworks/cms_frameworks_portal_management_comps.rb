# frozen_string_literal: true

class CmsFrameworksPortalManagementComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def xpath_link_activity_log
    "//a[text()='Activity Log']"
  end

  def link_activity_log
    find(:xpath, xpath_link_activity_log)
  end

  def xpath_link_upload_frameworks_register_xlsx
    "//a[text()='Upload Frameworks Register xlsx']"
  end

  def link_upload_frameworks_register_xlsx
    find(:xpath, xpath_link_upload_frameworks_register_xlsx)
  end
end
