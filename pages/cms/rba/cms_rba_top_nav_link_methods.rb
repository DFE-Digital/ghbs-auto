# frozen_string_literal: true

require "pages/shared/shared_global_methods"
require "pages/cms/cms_base_page"
require "components/cms/cms_top_nav_comps"
require "components/cms/cms_notifications_page_comps"
require "helpers/validation_helpers"
class CmsRbaTopNavLinkMethods < CmsBasePage
  include ValidationHelpers

  def top_nav_link_checker_only(
    notification: false,
    case_statistics: false,
    management: false,
    my_cases: false,
    frameworks: false
  )

    # Validate the top page links
    expect(element_present?(cms_top_nav_comps.xpath_link_notifications)).to be(notification)
    expect(element_present?(cms_top_nav_comps.xpath_link_case_statistics)).to be(case_statistics)
    expect(element_present?(cms_top_nav_comps.xpath_link_management)).to be(management)

    # E and O has a different name for "My cases" it calls it "Cases" hence the below check.
    if my_cases
      has_standard = element_present?(cms_top_nav_comps.xpath_link_my_cases)
      has_e_and_o  = element_present?(cms_top_nav_comps.xpath_link_my_cases_e_and_o)
      expect(has_standard || has_e_and_o).to be(true)
    end

    expect(element_present?(cms_top_nav_comps.xpath_link_frameworks)).to be(frameworks)
  end

  def top_nav_link_checker_for_visible_but_none_accessible(
    notification_visible: false,
    notification_reject_access: false,
    case_statistics_visible: false,
    case_statistics_reject_access: false,
    management_visible: false,
    management_reject_access: false,
    my_cases_visible: false,
    my_cases_reject_access: false,
    find_a_case_visible: false,
    find_a_case_reject_access: false,
    frameworks_visible: false,
    frameworks_reject_access: false
  )
    # This assumes that the links are there but when you access them you are told you don't have access.
    # This seems like an old quirk of older roles within the system and something we need to work around for now.

    # Validate the top page links

    # Notifications
    expect(element_present?(cms_top_nav_comps.xpath_link_notifications)).to be(notification_visible)
    if notification_visible
      cms_top_nav_comps.link_notifications.click
      if notification_reject_access
        validate_not_auth_to_access_page_and_return_to_case_stats
      end
    end

    # Case Statistics
    expect(element_present?(cms_top_nav_comps.xpath_link_case_statistics)).to be(case_statistics_visible)
    if case_statistics_visible
      cms_top_nav_comps.link_case_statistics.click
      if case_statistics_reject_access
        validate_not_auth_to_access_page_and_return_to_case_stats
      end
    end

    # Management
    expect(element_present?(cms_top_nav_comps.xpath_link_management)).to be(management_visible)
    if management_visible
      cms_top_nav_comps.link_management.click
      if management_reject_access
        validate_not_auth_to_access_page_and_return_to_case_stats
      end
    end

    # My Cases
    expect(element_present?(cms_top_nav_comps.xpath_link_my_cases)).to be(my_cases_visible)
    if my_cases_visible
      cms_top_nav_comps.link_my_cases.click
      if my_cases_reject_access
        validate_not_auth_to_access_page_and_return_to_case_stats
      end
    end

    # Find a Case
    expect(element_present?(cms_top_nav_comps.xpath_link_find_a_case)).to be(find_a_case_visible)
    if find_a_case_visible
      cms_top_nav_comps.link_find_a_case.click
      if find_a_case_reject_access
        validate_not_auth_to_access_page_and_return_to_case_stats
      end
    end

    # Frameworks
    expect(element_present?(cms_top_nav_comps.xpath_link_frameworks)).to be(frameworks_visible)
    if frameworks_visible
      cms_top_nav_comps.link_frameworks.click
      if frameworks_reject_access
        validate_not_auth_to_access_page_and_return_to_case_stats
      end
    end
  end

  def validate_not_auth_to_access_page_and_return_to_case_stats
    expect(page).to have_current_path(%r{/cms/not_authorized}, url: true, wait: 20)
    wait_for_element_to_include(cms_top_nav_comps.text_not_auth_header, "Supported Buying Case Management", timeout: 5)
    cms_top_nav_comps.link_go_home.click
    expect(page).to have_current_path(%r{/support/case_statistics#stats-by-person}, url: true, wait: 20)
    wait_for_element_to_include(cms_case_statistics_comps.text_page_heading, "Case statistics", timeout: 5)
  end

end
