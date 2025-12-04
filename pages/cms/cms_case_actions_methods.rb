# frozen_string_literal: true

require "pages/cms/cms_base_page"
require "components/cms/case/cms_single_case_actions_comps"
require "components/cms/case/cms_single_case_resolve_case_page_comps"
require "components/cms/case/cms_single_case_view_page_comps"
class CmsCaseActionsMethods < CmsBasePage
  def complete_resolve_case_flow
    case_status = cms_single_case_view_page_comps.text_case_status_badge.text.strip.squeeze(" ")

    if case_status == "On Hold"
      # sometimes the case is in an "On Hold" state, to close the case we first need to reopen it!
      cms_single_case_actions_comps.link_reopen_case.click
      expect(page).to have_current_path(%r{/onboarding_cases}, url: true, wait: 10)
      expect(cms_single_case_view_page_comps.text_flash_notice_content.text).to include("Case reopened successfully")
    end

    # navigate to the resolve case screen
    cms_single_case_actions_comps.link_resolve_case.click

    # confirm the page load
    expect(page).to have_current_path(%r{/cases}, url: true, wait: 10)
    expect(cms_single_case_resolve_case_page_comps.text_page_heading.text).to include("Resolve case")

    # enter text in to the notes field and complete the resolution
    cms_single_case_resolve_case_page_comps.input_notes.set("This is an auto test case resolution")
    cms_single_case_resolve_case_page_comps.button_save_and_close_case.click

    # confirm the resolution has been completed.
    expect(page).to have_current_path(%r{/onboarding_cases}, url: true, wait: 10)
    expect(cms_single_case_view_page_comps.text_flash_notice_content.text).to include("Case resolved successfully")
  end
end
