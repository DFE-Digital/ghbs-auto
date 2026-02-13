# frozen_string_literal: true

require "pages/shared/shared_global_methods"
require "pages/cms/cms_base_page"
require "components/cms/cms_top_nav_comps"
require "components/cms/frameworks/cms_frameworks_register_comps"
require "components/cms/frameworks/cms_frameworks_register_nav_comps"
require "components/cms/frameworks/cms_frameworks_portal_management_activity_log_comps"
require "components/cms/frameworks/cms_frameworks_portal_management_comps"
require "components/cms/frameworks/cms_frameworks_portal_management_upload_fw_comps"
require "helpers/validation_helpers"
class CmsRbaFrameworksMethods < CmsBasePage
  include ValidationHelpers

  def validate_frameworks_page(
    top_nav_frameworks_tab: false,
    sub_frameworks_register: false,
    sub_framework_evaluations: false,
    sub_provider_contacts: false,
    sub_providers: false
  )
    # Validate the top page link
    expect(element_present?(cms_top_nav_comps.xpath_link_frameworks)).to be(top_nav_frameworks_tab)

    if top_nav_frameworks_tab
      # Open Frameworks screen
      cms_top_nav_comps.link_frameworks.click
      expect(page).to have_current_path(%r{/frameworks#frameworks-register}, url: true, wait: 20)
      wait_for_element_to_include(cms_frameworks_register_nav_comps.link_frameworks_register, "Frameworks Register", timeout: 5)

      # Validate the Frameworks page tabs
      expect(element_present?(cms_frameworks_register_nav_comps.xpath_link_frameworks_register)).to be(sub_frameworks_register)
      expect(element_present?(cms_frameworks_register_nav_comps.xpath_link_framework_evaluations)).to be(sub_framework_evaluations)
      expect(element_present?(cms_frameworks_register_nav_comps.xpath_link_provider_contacts)).to be(sub_provider_contacts)
      expect(element_present?(cms_frameworks_register_nav_comps.xpath_link_providers)).to be(sub_providers)
    end
  end

  def validate_frameworks_management(
    top_nav_framework_management_portal: false,
    sub_activity_log: false,
    sub_upload_framework_register_xlsx: false
  )
    # Validate the top page link - Note that to see this you need to be on the frameworks register screen first!
    expect(element_present?(cms_top_nav_comps.xpath_link_management)).to be(top_nav_framework_management_portal)

    if top_nav_framework_management_portal
      # Open Frameworks Portal Management screen
      cms_top_nav_comps.link_management.click
      expect(page).to have_current_path(%r{/frameworks/management}, url: true, wait: 20)
      wait_for_element_to_include(cms_frameworks_portal_management_comps.text_page_heading, "Frameworks Portal Management", timeout: 5)

      # Validate the Frameworks Management Sub pages
      expect(element_present?(cms_frameworks_portal_management_comps.xpath_link_activity_log)).to be(sub_activity_log)

      if sub_activity_log
        # Open Activity Log screen
        cms_frameworks_portal_management_comps.link_activity_log.click
        expect(page).to have_current_path(%r{/frameworks/management/activity_log}, url: true, wait: 20)
        wait_for_element_to_include(cms_frameworks_portal_management_activity_log_comps.text_page_heading, "Activity Log", timeout: 5)

        # Return to the Frameworks Portal Management screen
        cms_top_nav_comps.link_management.click
        expect(page).to have_current_path(%r{/frameworks/management}, url: true, wait: 20)
        wait_for_element_to_include(cms_frameworks_portal_management_comps.text_page_heading, "Frameworks Portal Management", timeout: 5)
      end

      expect(element_present?(cms_frameworks_portal_management_comps.xpath_link_upload_frameworks_register_xlsx)).to be(sub_upload_framework_register_xlsx)

      if sub_upload_framework_register_xlsx
        # Open Upload Frameworks Register xlsx screen
        cms_frameworks_portal_management_comps.link_upload_frameworks_register_xlsx.click
        expect(page).to have_current_path(%r{frameworks/management/register_upload/new}, url: true, wait: 20)
        wait_for_element_to_include(cms_frameworks_portal_management_upload_fw_comps.text_page_heading, "Upload Frameworks Register xlsx", timeout: 5)
      end
    end
  end
end
