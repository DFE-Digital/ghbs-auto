# frozen_string_literal: true

require "pages/shared/shared_global_methods"
require "pages/cms/cms_base_page"
require "pages/cms/cms_top_nav_methods"
require "components/cms/management/cms_management_comps"
require "components/cms/management/cms_man_agents_list_comps"
require "components/cms/management/cms_man_agents_edit_agent_comps"
require "components/cms/management/cms_man_categories_list_comps"
require "components/cms/management/cms_man_email_templates_list_comps"
require "components/cms/management/cms_man_email_templates_edit_comps"
require "components/cms/management/cms_man_energy_for_schools_configure_email_comps"
require "components/cms/management/cms_man_sync_framework_comps"
require "components/cms/management/cms_man_all_cases_survey_comps"
require "components/cms/cms_case_statistics_comps"
require "components/cms/cms_top_nav_comps"
require "components/cms/cms_my_cases_sub_nav_comps"
require "components/cms/find_a_case/cms_find_a_case_page_comps"
require "components/cms/cms_mycases_page_comps"
require "components/cms/cms_notifications_page_comps"
require "components/cms/frameworks/cms_frameworks_register_comps"
require "components/cms/frameworks/cms_frameworks_register_nav_comps"
require "components/cms/frameworks/cms_frameworks_portal_management_activity_log_comps"
require "components/cms/frameworks/cms_frameworks_portal_management_comps"
require "components/cms/frameworks/cms_frameworks_portal_management_upload_fw_comps"

require "pages/cms/rba/cms_rba_case_statistics_methods"
require "pages/cms/rba/cms_rba_find_a_case_methods"
require "pages/cms/rba/cms_rba_frameworks_methods"
require "pages/cms/rba/cms_rba_management_methods"
require "pages/cms/rba/cms_rba_my_cases_methods"
require "pages/cms/rba/cms_rba_notifications_methods"
require "pages/cms/rba/cms_rba_top_nav_link_methods"

require "helpers/validation_helpers"

class CmsRoleBasedAccessMethods < CmsBasePage
  include ValidationHelpers

  def nav_to_agents_screen
    cms_management_comps.link_config_agents.click
    expect(page).to have_current_path(%r{/support/management/agents#current-accounts}, url: true, wait: 10)
    expect(cms_agents_list_comps.text_page_heading.text).to include("Agents")
  end

  def set_single_role_based_permission(agent, permission)
    # Find and edit our current target user
    cms_agents_list_comps.link_current_staff.click
    if agent == "rba_test_user_login"
      cms_agents_list_comps.link_edit_by_name("Auto 3 Test User 3").click
      expect(page).to have_current_path(%r{/edit}, url: true, wait: 10)
      expect(cms_agents_edit_agent_comps.text_page_heading.text).to include("Edit Auto 3 Test User 3")
    end

    # Reset all of our current users permissions
    reset_all_checkboxes

    # Set the new permissions to be Procurement Operations Admin
    select_permission(permission)
    cms_agents_edit_agent_comps.button_save.click
    expect(page).to have_current_path(%r{/support/management/agents#current-accounts}, url: true, wait: 10)
    expect(cms_agents_list_comps.text_page_heading.text).to include("Agents")

    # Save and validate the permissions have been applied
    validate_value_contains(permission, cms_agents_list_comps.text_see_roles_by_name("Auto 3 Test User 3").text)
  end

  def validate_visible_screens_based_on_user_type(role)
    case role
    when "Global Administrator"
      # Area: My Cases
      world.cms_rba_my_cases_methods.section_validation_my_cases_tabs(
        top_nav_my_cases: true,
        sub_nav_my_cases: true,
        sub_nav_fm: true,
        sub_nav_ict: true,
        sub_nav_energy: true,
        sub_nav_services: true,
        sub_nav_triage: true,
        sub_nav_new_cases: true,
        sub_nav_all_cases: true
      )

      # Area: Notifications
      world.cms_rba_notifications_methods.section_validation_notification_tab(notification: true)

      # Area: Case Statistics
      world.cms_rba_case_statistics_methods.section_case_statistics_tabs(
        main_case_statistics: true,
        overview_by_person_tab: true,
        overview_by_stage_tab: true,
        overview_by_category_tab: true
      )
      # Area: Management > Configuration
      world.cms_rba_management_methods.section_validation_management_tab(management_page: true)

      world.cms_rba_management_methods.validate_management_home_page(
        config_agents: true,
        config_categories: true,
        config_email_templates: true,
        config_energy_for_schools: true,
        tasks_synchronise_frameworks: true,
        tasks_all_cases_survey: true
      )

      # Area: Management > Configuration > Agents
      world.cms_rba_management_methods.section_validation_management_tab(management_page: true)

      world.cms_rba_management_methods.validate_agents_home_page(
        current_staff_tab: true,
        former_staff_tab: true
      )

      # Area: Management > Configuration > Categories
      world.cms_rba_management_methods.section_validation_management_tab(management_page: true)
      world.cms_rba_management_methods.validate_categories_page(category: true)

      # Area: Management > Configuration > Email templates
      world.cms_rba_management_methods.section_validation_management_tab(management_page: true)
      world.cms_rba_management_methods.validate_email_templates_page(email_templates: true)

      # Area: Management > Configuration > Energy for Schools
      world.cms_rba_management_methods.section_validation_management_tab(management_page: true)
      world.cms_rba_management_methods.validate_energy_for_schools_page(energy_for_schools_page: true)

      # Area: Management > Tasks Synchronise frameworks
      world.cms_rba_management_methods.section_validation_management_tab(management_page: true)
      world.cms_rba_management_methods.validate_sycn_framework_page(sync_frameworks_page: true)

      # Area: Management > Tasks All Cases Survey
      world.cms_rba_management_methods.section_validation_management_tab(management_page: true)
      world.cms_rba_management_methods.validate_all_cases_survey_page(all_surveys_page: true)

      # Area: Find a case
      world.cms_rba_find_a_case_methods.validate_find_a_case_page(top_nav_find_a_case_tab: true)

      # Area: Frameworks
      world.cms_rba_frameworks_methods.validate_frameworks_page(
        top_nav_frameworks_tab: true,
        sub_frameworks_register: true,
        sub_framework_evaluations: true,
        sub_provider_contacts: true,
        sub_providers: true
      )

      # Area: Frameworks Management
      world.cms_rba_frameworks_methods.validate_frameworks_management(
        top_nav_framework_management_portal: true,
        sub_activity_log: true,
        sub_upload_framework_register_xlsx: true
      )

    when "Procurement Operations Admin"
      # Area: My Cases
      world.cms_rba_my_cases_methods.section_validation_my_cases_tabs(
        top_nav_my_cases: true,
        sub_nav_my_cases: true,
        sub_nav_fm: true,
        sub_nav_ict: true,
        sub_nav_energy: true,
        sub_nav_services: true,
        sub_nav_triage: true,
        sub_nav_new_cases: true,
        sub_nav_all_cases: true
      )

      # Area: Notifications
      world.cms_rba_notifications_methods.section_validation_notification_tab(notification: true)

      # Area: Case Statistics
      world.cms_rba_case_statistics_methods.section_case_statistics_tabs(
        main_case_statistics: true,
        overview_by_person_tab: true,
        overview_by_stage_tab: true,
        overview_by_category_tab: true
      )

      # Area: Management > Configuration > Agents
      world.cms_rba_management_methods.section_validation_management_tab(management_page: true)

      world.cms_rba_management_methods.validate_agents_home_page(
        current_staff_tab: true,
        former_staff_tab: true
      )

      # Area: Management > Configuration > Categories
      world.cms_rba_management_methods.section_validation_management_tab(management_page: true)
      world.cms_rba_management_methods.validate_categories_page(category: true)

      # Area: Management > Configuration > Email templates
      world.cms_rba_management_methods.section_validation_management_tab(management_page: true)
      world.cms_rba_management_methods.validate_email_templates_page(email_templates: true)

      # Area: Management > Configuration > Energy for Schools
      world.cms_rba_management_methods.section_validation_management_tab(management_page: true)
      world.cms_rba_management_methods.validate_energy_for_schools_page(energy_for_schools_page: true)

      # Area: Management > Tasks Synchronise frameworks
      world.cms_rba_management_methods.section_validation_management_tab(management_page: true)
      world.cms_rba_management_methods.validate_sycn_framework_page(sync_frameworks_page: true)

      # Area: Management > Tasks All Cases Survey
      world.cms_rba_management_methods.section_validation_management_tab(management_page: true)
      world.cms_rba_management_methods.validate_all_cases_survey_page(all_surveys_page: true)

      # Area: Find a case
      world.cms_rba_find_a_case_methods.validate_find_a_case_page(top_nav_find_a_case_tab: true)

      # Area: Frameworks
      world.cms_rba_frameworks_methods.validate_frameworks_page(
        top_nav_frameworks_tab: true,
        sub_frameworks_register: true,
        sub_framework_evaluations: true,
        sub_provider_contacts: true,
        sub_providers: true
      )

      # Area: Frameworks Management
      world.cms_rba_frameworks_methods.validate_frameworks_management(
        top_nav_framework_management_portal: true,
        sub_activity_log: false,
        sub_upload_framework_register_xlsx: false
      )

    when "Procurement Operations Staff Member"
      # Area: My Cases
      world.cms_rba_my_cases_methods.section_validation_my_cases_tabs(
        top_nav_my_cases: true,
        sub_nav_my_cases: true,
        sub_nav_fm: true,
        sub_nav_ict: true,
        sub_nav_energy: true,
        sub_nav_services: true,
        sub_nav_triage: true,
        sub_nav_new_cases: true,
        sub_nav_all_cases: true
      )

      # Area: Notifications
      world.cms_rba_notifications_methods.section_validation_notification_tab(notification: true)

      # Area: Case Statistics
      world.cms_rba_case_statistics_methods.section_case_statistics_tabs(
        main_case_statistics: true,
        overview_by_person_tab: true,
        overview_by_stage_tab: true,
        overview_by_category_tab: true
      )

      # Area: Management > Configuration > Agents
      world.cms_rba_management_methods.section_validation_management_tab(management_page: false)

      # Area: Find a case
      world.cms_rba_find_a_case_methods.validate_find_a_case_page(top_nav_find_a_case_tab: true)

      # Area: Frameworks
      world.cms_rba_frameworks_methods.validate_frameworks_page(
        top_nav_frameworks_tab: true,
        sub_frameworks_register: true,
        sub_framework_evaluations: true,
        sub_provider_contacts: true,
        sub_providers: true
      )

      # Area: Frameworks Management
      world.cms_rba_frameworks_methods.validate_frameworks_management(
        top_nav_framework_management_portal: false
      )

    when "Engagement and Outreach Admin"
      world.cms_rba_top_nav_link_methods.top_nav_link_checker_only(
        notification: false,
        case_statistics: false,
        management: true,
        my_cases: true,
        find_a_case: false,
        frameworks: false
      )

      # Area: My Cases
      world.cms_rba_my_cases_methods.section_validation_my_cases_tabs(
        top_nav_my_cases: true,
        sub_nav_my_cases: true,
        sub_nav_fm: false,
        sub_nav_ict: false,
        sub_nav_energy: false,
        sub_nav_services: false,
        sub_nav_triage: false,
        sub_nav_new_cases: false,
        sub_nav_all_cases: true
      )

      # Area: Management > Configuration
      world.cms_rba_management_methods.section_validation_management_tab(management_page: true)

      world.cms_rba_management_methods.validate_management_home_page(
        config_agents: true,
        config_categories: false,
        config_email_templates: false,
        config_energy_for_schools: false,
        tasks_synchronise_frameworks: false,
        tasks_all_cases_survey: false
      )

      world.cms_rba_management_methods.validate_agents_home_page(
        current_staff_tab: true,
        former_staff_tab: true
      )

    when "Engagement and Outreach Staff Member"
      world.cms_rba_top_nav_link_methods.top_nav_link_checker_only(
        notification: false,
        case_statistics: false,
        management: false,
        my_cases: true,
        find_a_case: false,
        frameworks: false
      )

      # Area: My Cases
      world.cms_rba_my_cases_methods.section_validation_my_cases_tabs(
        top_nav_my_cases: true,
        sub_nav_my_cases: true,
        sub_nav_fm: false,
        sub_nav_ict: false,
        sub_nav_energy: false,
        sub_nav_services: false,
        sub_nav_triage: false,
        sub_nav_new_cases: false,
        sub_nav_all_cases: true
      )

    when "Digital Team Staff Member"
      # Area: My Cases
      world.cms_rba_my_cases_methods.section_validation_my_cases_tabs(
        top_nav_my_cases: true,
        sub_nav_my_cases: true,
        sub_nav_fm: true,
        sub_nav_ict: true,
        sub_nav_energy: true,
        sub_nav_services: true,
        sub_nav_triage: true,
        sub_nav_new_cases: true,
        sub_nav_all_cases: true
      )

      # Area: Notifications
      world.cms_rba_notifications_methods.section_validation_notification_tab(notification: true)

      # Area: Case Statistics
      world.cms_rba_case_statistics_methods.section_case_statistics_tabs(
        main_case_statistics: true,
        overview_by_person_tab: true,
        overview_by_stage_tab: true,
        overview_by_category_tab: true
      )

      # Area: Management > Configuration > Agents
      world.cms_rba_management_methods.section_validation_management_tab(management_page: false)

      # Area: Find a case
      world.cms_rba_find_a_case_methods.validate_find_a_case_page(top_nav_find_a_case_tab: true)

      # Area: Frameworks
      world.cms_rba_frameworks_methods.validate_frameworks_page(
        top_nav_frameworks_tab: true,
        sub_frameworks_register: true,
        sub_framework_evaluations: true,
        sub_provider_contacts: true,
        sub_providers: true
      )

      # Area: Frameworks Management
      world.cms_rba_frameworks_methods.validate_frameworks_management(
        top_nav_framework_management_portal: false
      )

    when "Data Analyst"
      world.cms_rba_top_nav_link_methods.top_nav_link_checker_for_visible_but_none_accessible(
        notification_visible: true,
        notification_reject_access: true,
        case_statistics_visible: true,
        case_statistics_reject_access: false,
        management_visible: false,
        management_reject_access: false,
        my_cases_visible: true,
        my_cases_reject_access: true,
        find_a_case_visible: true,
        find_a_case_reject_access: true,
        frameworks_visible: false,
        frameworks_reject_access: false
      )

      # Area: Case Statistics
      world.cms_rba_case_statistics_methods.section_case_statistics_tabs(
        main_case_statistics: true,
        overview_by_person_tab: true,
        overview_by_stage_tab: true,
        overview_by_category_tab: true
      )


    when "Framework Evaluator Admin"
      world.cms_rba_top_nav_link_methods.top_nav_link_checker_only(
        notification: false,
        case_statistics: false,
        management: true,
        my_cases: false,
        find_a_case: false,
        frameworks: true
      )

      # Area: Frameworks
      world.cms_rba_frameworks_methods.validate_frameworks_page(
        top_nav_frameworks_tab: true,
        sub_frameworks_register: true,
        sub_framework_evaluations: true,
        sub_provider_contacts: true,
        sub_providers: true
      )

      # Area: Frameworks - Management
      world.cms_rba_frameworks_methods.validate_frameworks_management(
        top_nav_framework_management_portal: true,
        sub_activity_log: true,
        sub_upload_framework_register_xlsx: true
      )

    when "Framework Evaluator"
      world.cms_rba_top_nav_link_methods.top_nav_link_checker_only(
        notification: false,
        case_statistics: false,
        management: false,
        my_cases: false,
        find_a_case: false,
        frameworks: true
      )

      # Area: Frameworks
      world.cms_rba_frameworks_methods.validate_frameworks_page(
        top_nav_frameworks_tab: true,
        sub_frameworks_register: true,
        sub_framework_evaluations: true,
        sub_provider_contacts: true,
        sub_providers: true
      )

    when "CEC Staff Member"
      world.cms_rba_top_nav_link_methods.top_nav_link_checker_only(
        notification: true,
        case_statistics: false,
        management: false,
        my_cases: true,
        find_a_case: true,
        frameworks: false
      )

      # Area: My Cases
      world.cms_rba_my_cases_methods.section_validation_my_cases_tabs(
        top_nav_my_cases: true,
        sub_nav_my_cases: true,
        sub_nav_fm: false,
        sub_nav_ict: false,
        sub_nav_energy: false,
        sub_nav_services: false,
        sub_nav_triage: false,
        sub_nav_new_cases: false,
        sub_nav_all_cases: true
      )

    when "CEC Admin"
      world.cms_rba_top_nav_link_methods.top_nav_link_checker_only(
        notification: true,
        case_statistics: false,
        management: true,
        my_cases: true,
        find_a_case: true,
        frameworks: false
      )

      # Area: My Cases
      world.cms_rba_my_cases_methods.section_validation_my_cases_tabs(
        top_nav_my_cases: true,
        sub_nav_my_cases: true,
        sub_nav_fm: false,
        sub_nav_ict: false,
        sub_nav_energy: false,
        sub_nav_services: false,
        sub_nav_triage: false,
        sub_nav_new_cases: false,
        sub_nav_all_cases: true
      )

      # Area: Management > Configuration > Agents
      world.cms_rba_management_methods.section_validation_management_tab(management_page: true)

      world.cms_rba_management_methods.validate_agents_home_page(
        current_staff_tab: true,
        former_staff_tab: false
      )

      # Area: Management > Configuration > Categories
      world.cms_rba_management_methods.section_validation_management_tab(management_page: true)
      world.cms_rba_management_methods.validate_categories_page(category: false)

      # Area: Management > Configuration > Email templates
      world.cms_rba_management_methods.section_validation_management_tab(management_page: true)
      world.cms_rba_management_methods.validate_email_templates_page(email_templates: true)

      # Area: Management > Configuration > Energy for Schools
      world.cms_rba_management_methods.section_validation_management_tab(management_page: true)
      world.cms_rba_management_methods.validate_energy_for_schools_page(energy_for_schools_page: false)

      # Area: Management > Tasks Synchronise frameworks
      world.cms_rba_management_methods.section_validation_management_tab(management_page: true)
      world.cms_rba_management_methods.validate_sycn_framework_page(sync_frameworks_page: false)

      # Area: Management > Tasks All Cases Survey
      world.cms_rba_management_methods.section_validation_management_tab(management_page: true)
      world.cms_rba_management_methods.validate_all_cases_survey_page(all_surveys_page: false)

    else
      raise ArgumentError, "[FAIL] Role '#{role}' is not a recognised role in the system"
    end
  end

private

  def reset_all_checkboxes
    rba_roles = cms_agents_edit_agent_comps

    rba_roles.checkbox_label_pairs.each do |checkbox_method, label_method|
      checkbox = rba_roles.public_send(checkbox_method)
      rba_roles.public_send(label_method).click if checkbox.checked?
    end
  end

  def select_permission(permission)
    case permission
    when "Global Administrator"
      cms_agents_edit_agent_comps.label_global_administrator.set(true)

    when "Procurement Operations Admin"
      cms_agents_edit_agent_comps.label_procurement_operations_admin.set(true)

    when "Procurement Operations Staff Member"
      cms_agents_edit_agent_comps.label_procurement_operations_staff_member.set(true)

    when "Engagement and Outreach Admin"
      cms_agents_edit_agent_comps.label_engagement_and_outreach_admin.set(true)

    when "Engagement and Outreach Staff Member"
      cms_agents_edit_agent_comps.label_engagement_and_outreach_staff_member.set(true)

    when "Digital Team Staff Member"
      cms_agents_edit_agent_comps.label_digital_team_staff_member.set(true)

    when "Data Analyst"
      cms_agents_edit_agent_comps.label_data_analyst.set(true)

    when "Framework Evaluator Admin"
      cms_agents_edit_agent_comps.label_framework_evaluator_admin.set(true)

    when "Framework Evaluator"
      cms_agents_edit_agent_comps.label_framework_evaluator.set(true)

    when "CEC Staff Member"
      cms_agents_edit_agent_comps.label_cec_staff_member.set(true)

    when "CEC Admin"
      cms_agents_edit_agent_comps.label_cec_admin.set(true)
    else
      raise ArgumentError, "permission '#{permission}' is not a role in the system"
    end
  end
end
