# frozen_string_literal: true

require "pages/cms/cms_base_page"
require "components/cms/cms_top_nav_comps"
require "components/cms/cms_notifications_page_comps"
require "components/cms/cms_mycases_page_comps"
require "components/cms/find_a_case/cms_find_a_case_page_comps"

class CmsTopNavMethods < CmsBasePage
  def nav_to_notifications_screen
    cms_top_nav_comps.link_notifications.click
    expect(page).to have_current_path(%r{/support/notifications}, url: true, wait: 10)
    expect(cms_notifications_page_comps.text_page_heading.text).to include("Notifications")
  end

  def nav_to_cases_screen
    cms_top_nav_comps.link_cases.click
    expect(page).to have_current_path(%r{/cases#my-cases}, url: true, wait: 10)
    expect(cms_mycases_page_comps.text_page_heading.text).to include("My cases")
  end

  def nav_to_find_a_case_screen
    cms_top_nav_comps.link_find_a_case.click
    expect(page).to have_current_path(%r{cases/find-a-case/new}, url: true, wait: 10)
    expect(cms_find_a_case_page_comps.text_page_heading.text).to include("Find a case")
  end

  def click_sign_out_button
    # TODO: add the sign out flow
  end
end
