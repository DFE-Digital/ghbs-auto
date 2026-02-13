# frozen_string_literal: true

require "pages/shared/shared_global_methods"
require "pages/cms/cms_base_page"
require "components/cms/cms_top_nav_comps"
require "components/cms/cms_notifications_page_comps"
require "helpers/validation_helpers"
class CmsRbaNotificationsMethods < CmsBasePage
  include ValidationHelpers

  def section_validation_notification_tab(
    notification: false
  )
    # Validate the top page link
    expect(element_present?(cms_top_nav_comps.xpath_link_notifications)).to be(notification)

    if notification
      # Nav to my notification screen
      cms_top_nav_comps.link_notifications.click
      expect(page).to have_current_path(%r{support/notifications}, url: true, wait: 20)
      wait_for_element_to_include(cms_notifications_page_comps.text_page_heading, "Notifications", timeout: 5)
    end
  end
end
