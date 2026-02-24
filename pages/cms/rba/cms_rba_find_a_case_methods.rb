# frozen_string_literal: true

require "pages/shared/shared_global_methods"
require "pages/cms/cms_base_page"
require "components/cms/cms_top_nav_comps"
require "components/cms/find_a_case/cms_find_a_case_page_comps"
require "helpers/validation_helpers"
class CmsRbaFindACaseMethods < CmsBasePage
  include ValidationHelpers

  def validate_find_a_case_page(
    top_nav_find_a_case_tab: false
  )
    expect(element_present?(cms_top_nav_comps.xpath_link_find_a_case)).to be(top_nav_find_a_case_tab)
    if top_nav_find_a_case_tab
      # Open Find a case screen
      cms_top_nav_comps.link_find_a_case.click
      expect(page).to have_current_path(%r{/support/cases/find-a-case/new}, url: true, wait: 20)
      wait_for_element_to_include(cms_find_a_case_page_comps.text_page_heading, "Find a case", timeout: 5)
    end
  end

  def validate_find_a_case_view_permissions
    # Validate the expected selectable roles
    case current_user_state.role
    when "Global Administrator"
      section_validate_find_a_case_view_permissions(
        level_1_case_visibility: true,
        level_2_case_visibility: true,
        level_3_case_visibility: true,
        level_4_case_visibility: true,
        level_5_case_visibility: true,
        level_6_case_visibility: true,
        level_7_case_visibility: true
      )

    when "Procurement Operations Admin"
      section_validate_find_a_case_view_permissions(
        level_1_case_visibility: true,
        level_2_case_visibility: true,
        level_3_case_visibility: true,
        level_4_case_visibility: true,
        level_5_case_visibility: true,
        level_6_case_visibility: true,
        level_7_case_visibility: true
      )

    when "Procurement Operations Staff Member"
      section_validate_find_a_case_view_permissions(
        level_1_case_visibility: true,
        level_2_case_visibility: true,
        level_3_case_visibility: true,
        level_4_case_visibility: true,
        level_5_case_visibility: true,
        level_6_case_visibility: true,
        level_7_case_visibility: true
      )

    when "Digital Team Staff Member"
      section_validate_find_a_case_view_permissions(
        level_1_case_visibility: true,
        level_2_case_visibility: true,
        level_3_case_visibility: true,
        level_4_case_visibility: true,
        level_5_case_visibility: true,
        level_6_case_visibility: true,
        level_7_case_visibility: true
      )

    when "CEC Staff Member"
      section_validate_find_a_case_view_permissions(
        level_1_case_visibility: false,
        level_2_case_visibility: false,
        level_3_case_visibility: false,
        level_4_case_visibility: false,
        level_5_case_visibility: false,
        level_6_case_visibility: true,
        level_7_case_visibility: true
      )

    when "CEC Admin"
      section_validate_find_a_case_view_permissions(
        level_1_case_visibility: false,
        level_2_case_visibility: false,
        level_3_case_visibility: false,
        level_4_case_visibility: false,
        level_5_case_visibility: false,
        level_6_case_visibility: true,
        level_7_case_visibility: true
      )

    else
      raise ArgumentError, "Role '#{current_user_state.role}' is not a role we think should have agent permissions"
    end
  end

  def section_validate_find_a_case_view_permissions(
    level_1_case_visibility: false,
    level_2_case_visibility: false,
    level_3_case_visibility: false,
    level_4_case_visibility: false,
    level_5_case_visibility: false,
    level_6_case_visibility: false,
    level_7_case_visibility: false
  )
    nav_to_find_a_case_screen

    # Search for a level 1 case
    level_1_case_number = "001674"
    world.cms_find_a_case_methods.search_for_case(level_1_case_number)
    expect(element_present?(cms_search_results_page_comps.xpath_link_case_number(level_1_case_number))).to be(level_1_case_visibility)
    nav_to_find_a_case_screen

    # Search for a level 2 case
    level_2_case_number = "001661"
    world.cms_find_a_case_methods.search_for_case(level_2_case_number)
    expect(element_present?(cms_search_results_page_comps.xpath_link_case_number(level_2_case_number))).to be(level_2_case_visibility)
    nav_to_find_a_case_screen

    # Search for a level 3 case
    level_3_case_number = "001667"
    world.cms_find_a_case_methods.search_for_case(level_3_case_number)
    expect(element_present?(cms_search_results_page_comps.xpath_link_case_number(level_3_case_number))).to be(level_3_case_visibility)
    nav_to_find_a_case_screen

    # Search for a level 4 case
    level_4_case_number = "001671"
    world.cms_find_a_case_methods.search_for_case(level_4_case_number)
    expect(element_present?(cms_search_results_page_comps.xpath_link_case_number(level_4_case_number))).to be(level_4_case_visibility)
    nav_to_find_a_case_screen

    # Search for a level 5 case
    level_5_case_number = "001672"
    world.cms_find_a_case_methods.search_for_case(level_5_case_number)
    expect(element_present?(cms_search_results_page_comps.xpath_link_case_number(level_5_case_number))).to be(level_5_case_visibility)
    nav_to_find_a_case_screen

    # Search for a level 6 case
    level_6_case_number = "001673"
    world.cms_find_a_case_methods.search_for_case(level_6_case_number)
    expect(element_present?(cms_search_results_page_comps.xpath_link_case_number(level_6_case_number))).to be(level_6_case_visibility)
    nav_to_find_a_case_screen

    # Search for a level 7 case
    level_7_case_number = "001675"
    world.cms_find_a_case_methods.search_for_case(level_7_case_number)
    expect(element_present?(cms_search_results_page_comps.xpath_link_case_number(level_7_case_number))).to be(level_7_case_visibility)
    nav_to_find_a_case_screen


  end

  def nav_to_find_a_case_screen
    # Open Find a case screen
    cms_top_nav_comps.link_find_a_case.click
    expect(page).to have_current_path(%r{#{current_user_state.base_url}/cases/find-a-case/new}, url: true, wait: 20)
    wait_for_element_to_include(cms_find_a_case_page_comps.text_page_heading, "Find a case", timeout: 5)
  end

end
