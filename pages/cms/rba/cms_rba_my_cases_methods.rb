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
      expect(page).to have_current_path(%r{#{current_user_state.base_url}#my-cases}, url: true, wait: 20)

      if ["Engagement and Outreach Admin", "Engagement and Outreach Staff Member", "CEC Staff Member", "CEC Admin"].include?(current_user_state.role)
        expect(element_present?(cms_top_nav_comps.xpath_link_my_cases_e_and_o)).to be(top_nav_my_cases)
        wait_for_element_to_include(cms_mycases_page_comps.text_page_heading, "My cases", timeout: 5)
        cms_top_nav_comps.link_my_cases_e_and_o.click
      else
        expect(element_present?(cms_top_nav_comps.xpath_link_my_cases)).to be(top_nav_my_cases)
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

  def validate_my_cases_view_levels
    # Validate the expected selectable roles
    case current_user_state.role
    when "Global Administrator"
      section_my_cases_view_levels(
        level_1_case_visibility: true,
        level_2_case_visibility: true,
        level_3_case_visibility: true,
        level_4_case_visibility: true,
        level_5_case_visibility: true,
        level_6_case_visibility: true,
        level_7_case_visibility: true
      )

    when "Procurement Operations Admin"
      section_my_cases_view_levels(
        level_1_case_visibility: true,
        level_2_case_visibility: true,
        level_3_case_visibility: true,
        level_4_case_visibility: true,
        level_5_case_visibility: true,
        level_6_case_visibility: true,
        level_7_case_visibility: true
      )

    when "Procurement Operations Staff Member"
      section_my_cases_view_levels(
        level_1_case_visibility: true,
        level_2_case_visibility: true,
        level_3_case_visibility: true,
        level_4_case_visibility: true,
        level_5_case_visibility: true,
        level_6_case_visibility: true,
        level_7_case_visibility: true
      )

    when "Digital Team Staff Member"
      section_my_cases_view_levels(
        level_1_case_visibility: true,
        level_2_case_visibility: true,
        level_3_case_visibility: true,
        level_4_case_visibility: true,
        level_5_case_visibility: true,
        level_6_case_visibility: true,
        level_7_case_visibility: true
      )

    when "CEC Staff Member"
      section_my_cases_view_levels(
        level_1_case_visibility: false,
        level_2_case_visibility: false,
        level_3_case_visibility: false,
        level_4_case_visibility: false,
        level_5_case_visibility: false,
        level_6_case_visibility: true,
        level_7_case_visibility: true
      )

    when "CEC Admin"
      section_my_cases_view_levels(
        level_1_case_visibility: false,
        level_2_case_visibility: false,
        level_3_case_visibility: false,
        level_4_case_visibility: false,
        level_5_case_visibility: false,
        level_6_case_visibility: true,
        level_7_case_visibility: true
      )

    else
      raise ArgumentError, "Role '#{current_user_state.role}' is not a role we think should see the my cases section/screen"
    end
  end

  def section_my_cases_view_levels(
    level_1_case_visibility: false,
    level_2_case_visibility: false,
    level_3_case_visibility: false,
    level_4_case_visibility: false,
    level_5_case_visibility: false,
    level_6_case_visibility: false,
    level_7_case_visibility: false
  )
    open_my_cases

    validate_case_visibility_for_level_with_reload(1, "001674", level_1_case_visibility)
    validate_case_visibility_for_level_with_reload(2, "001661", level_2_case_visibility)
    validate_case_visibility_for_level_with_reload(3, "001667", level_3_case_visibility)
    validate_case_visibility_for_level_with_reload(4, "001671", level_4_case_visibility)
    validate_case_visibility_for_level_with_reload(5, "001672", level_5_case_visibility)
    validate_case_visibility_for_level_with_reload(6, "001673", level_6_case_visibility)
    validate_case_visibility_for_level_with_reload(7, "001675", level_7_case_visibility)
  end



private

  def open_my_cases
    if ["Engagement and Outreach Admin", "Engagement and Outreach Staff Member", "CEC Staff Member", "CEC Admin"].include?(current_user_state.role)
      cms_top_nav_comps.link_my_cases_e_and_o.click
      expect(element_present?(cms_top_nav_comps.xpath_link_my_cases_e_and_o)).to be(true)
    else
      cms_top_nav_comps.link_my_cases.click
      expect(element_present?(cms_top_nav_comps.xpath_link_my_cases)).to be(true)
    end
    wait_for_element_to_include(cms_mycases_page_comps.text_page_heading, "My cases", timeout: 5)
  end

  def filter_by_level(level)
    checkbox_all = cms_mycases_page_comps.checkbox_level_all
    cms_mycases_page_comps.label_level_all.click unless checkbox_all.checked?

    case level
    when 1
      cms_mycases_page_comps.label_level_1.click
      expect(page).to have_selector(:xpath, cms_mycases_page_comps.xpath_checkbox_level_1, visible: :all, wait: 5)
      checkbox = find(:xpath, cms_mycases_page_comps.xpath_checkbox_level_1, visible: :all, wait: 2)
      expect(checkbox.checked?).to be(true)
    when 2
      cms_mycases_page_comps.label_level_2.click
      expect(page).to have_selector(:xpath, cms_mycases_page_comps.xpath_checkbox_level_2, visible: :all, wait: 5)
      checkbox = find(:xpath, cms_mycases_page_comps.xpath_checkbox_level_2, visible: :all, wait: 2)
      expect(checkbox.checked?).to be(true)
    when 3
      cms_mycases_page_comps.label_level_3.click
      expect(page).to have_selector(:xpath, cms_mycases_page_comps.xpath_checkbox_level_3, visible: :all, wait: 5)
      checkbox = find(:xpath, cms_mycases_page_comps.xpath_checkbox_level_3, visible: :all, wait: 2)
      expect(checkbox.checked?).to be(true)
    when 4
      cms_mycases_page_comps.label_level_4.click
      expect(page).to have_selector(:xpath, cms_mycases_page_comps.xpath_checkbox_level_4, visible: :all, wait: 5)
      checkbox = find(:xpath, cms_mycases_page_comps.xpath_checkbox_level_4, visible: :all, wait: 2)
      expect(checkbox.checked?).to be(true)
    when 5
      cms_mycases_page_comps.label_level_5.click
      expect(page).to have_selector(:xpath, cms_mycases_page_comps.xpath_checkbox_level_5, visible: :all, wait: 5)
      checkbox = find(:xpath, cms_mycases_page_comps.xpath_checkbox_level_5, visible: :all, wait: 2)
      expect(checkbox.checked?).to be(true)
    when 6
      cms_mycases_page_comps.label_level_6.click
      expect(page).to have_selector(:xpath, cms_mycases_page_comps.xpath_checkbox_level_6, visible: :all, wait: 5)
      checkbox = find(:xpath, cms_mycases_page_comps.xpath_checkbox_level_6, visible: :all, wait: 2)
      expect(checkbox.checked?).to be(true)
    when 7
      cms_mycases_page_comps.label_level_7.click
      expect(page).to have_selector(:xpath, cms_mycases_page_comps.xpath_checkbox_level_7, visible: :all, wait: 5)
      checkbox = find(:xpath, cms_mycases_page_comps.xpath_checkbox_level_7, visible: :all, wait: 2)
      expect(checkbox.checked?).to be(true)
    else
      raise ArgumentError, "Level '#{clevel}' is not a level option"
    end
  end

  def validate_case_visibility_for_level(level, case_number, expected_visibility)
    filter_by_level(level)

    expect(
      element_present?(
        cms_mycases_page_comps.xpath_link_case(case_number),
        wait: 5
      )
    ).to be(expected_visibility)
  end

  def validate_case_visibility_for_level_with_reload(level, case_number, expected_visibility)
    validate_case_visibility_for_level(level, case_number, expected_visibility)
  rescue RSpec::Expectations::ExpectationNotMetError, Capybara::ElementNotFound
    open_my_cases
    validate_case_visibility_for_level(level, case_number, expected_visibility)
  end


end
