# frozen_string_literal: true

require "pages/shared/shared_global_methods"
require "pages/cms/cms_base_page"
require "components/cms/cms_top_nav_comps"
require "components/cms/cms_my_cases_sub_nav_comps"
require "components/cms/cms_mycases_page_comps"
require "helpers/validation_helpers"
class CmsRbaMyCasesMethods < CmsBasePage
  include ValidationHelpers

  def section_validation_my_cases_tabs(
    top_nav_my_cases: false,
    sub_nav_my_cases: false,
    sub_nav_fm: false,
    sub_nav_ict: false,
    sub_nav_energy: false,
    sub_nav_services: false,
    sub_nav_triage: false,
    sub_nav_new_cases: false,
    sub_nav_all_cases: false
  )

    # Validate the top page link
    if top_nav_my_cases
      # Nav to my cases screen
      if ["Engagement and Outreach Admin", "Engagement and Outreach Staff Member"].include?(current_user_state.role)
        expect(element_present?(cms_top_nav_comps.xpath_link_my_cases_e_and_o)).to be(top_nav_my_cases)
        expect(page).to have_current_path(%r{engagement#my-cases}, url: true, wait: 20)
        wait_for_element_to_include(cms_mycases_page_comps.text_page_heading, "My cases", timeout: 5)
        cms_top_nav_comps.link_my_cases_e_and_o.click
      elsif ["CEC Staff Member", "CEC Admin"].include?(current_user_state.role)
        expect(element_present?(cms_top_nav_comps.xpath_link_my_cases)).to be(top_nav_my_cases)
        expect(page).to have_current_path(%r{/cec#my-cases}, url: true, wait: 20)
        wait_for_element_to_include(cms_mycases_page_comps.text_page_heading, "My cases", timeout: 5)
        cms_top_nav_comps.link_my_cases.click
      else
        expect(element_present?(cms_top_nav_comps.xpath_link_my_cases)).to be(top_nav_my_cases)
        expect(page).to have_current_path(%r{/support#my-cases}, url: true, wait: 20)
        wait_for_element_to_include(cms_mycases_page_comps.text_page_heading, "My cases", timeout: 5)
        cms_top_nav_comps.link_my_cases.click
      end

      # Validate the remaining tabs that are only visible of you have the "my cases" screen
      expect(element_present?(cms_my_cases_sub_nav_comps.xpath_link_my_cases)).to be(sub_nav_my_cases)
      expect(element_present?(cms_my_cases_sub_nav_comps.xpath_link_fm)).to be(sub_nav_fm)
      expect(element_present?(cms_my_cases_sub_nav_comps.xpath_link_ict)).to be(sub_nav_ict)
      expect(element_present?(cms_my_cases_sub_nav_comps.xpath_link_energy)).to be(sub_nav_energy)
      expect(element_present?(cms_my_cases_sub_nav_comps.xpath_link_services)).to be(sub_nav_services)
      expect(element_present?(cms_my_cases_sub_nav_comps.xpath_link_triage)).to be(sub_nav_triage)
      expect(element_present?(cms_my_cases_sub_nav_comps.xpath_new_cases)).to be(sub_nav_new_cases)
      expect(element_present?(cms_my_cases_sub_nav_comps.xpath_link_all_cases)).to be(sub_nav_all_cases)
    end
  end
end
