# frozen_string_literal: true

require "pages/cms/cms_base_page"
require "components/cms/cms_notifications_page_comps"
require "components/cms/cms_top_nav_comps"
require "components/cms/cms_mycases_page_comps"
require "helpers/validation_helpers"

class CmsNotificationsMethods < CmsBasePage
  include ValidationHelpers

  def validate_notification_from_evaluation_has_arrived
    # Return to the CMS home page
    visit SECRETS["dev_proc_ops_cms_homepage_url"]
    expect(page).to have_current_path(%r{/support#my-cases}, url: true, wait: 10)
    expect(cms_mycases_page_comps.text_page_heading.text).to include("My cases")

    # Navigate to the notifications page
    cms_top_nav_comps.link_notifications.click
    expect(page).to have_current_path(%r{/support/notifications}, url: true, wait: 10)
    wait_for_element_to_include(cms_notifications_page_comps.text_page_heading, "Notifications", timeout: 5)

    # Confirm notification has been received
    cms_notifications_page_comps.text_evaluation_notification_school_evaluated(case_state.case_number)
  end
end
