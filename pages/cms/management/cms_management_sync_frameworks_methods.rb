# frozen_string_literal: true

require "pages/cms/cms_base_page"
require "helpers/validation_helpers"
require "components/cms/cms_top_nav_comps"
require "components/cms/management/cms_management_comps"
require "components/cms/management/cms_management_sync_framework_comps"

class CmsManagementSyncFrameworksMethods < CmsBasePage
  include ValidationHelpers

  def run_the_sync_job
    # Navigate  to the Management section
    cms_top_nav_comps.link_management.click
    expect(page).to have_current_path(%r{/support/management}, url: true, wait: 10)
    expect(cms_management_comps.text_page_heading.text).to include("CMS Management")

    # Navigate to the Sync job page
    cms_management_comps.link_tasks_sync_frameworks.click
    expect(page).to have_current_path(%r{/support/management/sync_frameworks}, url: true, wait: 10)
    expect(cms_management_sync_framework_comps.text_page_heading.text).to include("Synchronise frameworks")

    # Run the sync job and confirm the task is triggered
    cms_management_sync_framework_comps.button_synchronise.click
    expect(cms_management_sync_framework_comps.text_notice.text).to include("Task triggered")
  end
end
