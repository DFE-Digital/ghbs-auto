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
    validate_value_contains("Procurement Operations Admin", cms_agents_list_comps.text_see_roles_by_name("Auto 3 Test User 3").text)
  end

  def validate_visible_screens_based_on_user_type(role)
    case role
    when "Global Administrator"
      # Area: My Cases
      section_validation_my_cases_tabs(
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
      section_validation_management_tab(management_page: true)

      # Area: Case Statistics
      section_case_statistics_tabs(
        main_case_statistics: true,
        overview_by_person_tab: true,
        overview_by_stage_tab: true,
        overview_by_category_tab: true
      )
      # Area: Management > Configuration
      section_validation_management_tab(management_page: true)

      validate_management_home_page(
        config_agents: true,
        config_categories: true,
        config_email_templates: true,
        config_energy_for_schools: true,
        tasks_synchronise_frameworks: true,
        tasks_all_cases_survey: true
      )

      # Area: Management > Configuration > Agents
      section_validation_management_tab(management_page: true)

      validate_agents_home_page(
        current_staff_tab: true,
        former_staff_tab: true
      )

      # Area: Management > Configuration > Categories
      section_validation_management_tab(management_page: true)
      validate_categories_page(category: true)

      # Area: Management > Configuration > Email templates
      section_validation_management_tab(management_page: true)
      validate_email_templates_page(email_templates: true)

      # Area: Management > Configuration > Energy for Schools
      section_validation_management_tab(management_page: true)
      validate_energy_for_schools_page(energy_for_schools_page: true)

      # Area: Management > Tasks Synchronise frameworks
      section_validation_management_tab(management_page: true)
      validate_sycn_framework_page(sync_frameworks_page: true)

      # Area: Management > Tasks All Cases Survey
      section_validation_management_tab(management_page: true)
      validate_all_cases_survey_page(all_surveys_page: true)

      # Area: Find a case
      validate_find_a_case_page(top_nav_find_a_case_tab: true)

      # Area: Frameworks
      validate_frameworks_page(
        top_nav_frameworks_tab: true,
        sub_frameworks_register: true,
        sub_framework_evaluations: true,
        sub_provider_contacts: true,
        sub_providers: true
      )

      # Area: Frameworks Management

    when "Procurement Operations Admin"
      # Area: My Cases
      # Area: Notifications
      # Area: Case Statistics
      # Area: Management > Configuration
      # Area: Management > Tasks
      # Area: Email Templates
      # Area: Find a case
      # Area: Frameworks

    when "Procurement Operations Staff Member"
      # Area: My Cases
      # Area: Notifications
      # Area: Case Statistics
      # Area: Find a case
      # Area: Frameworks

    when "Engagement and Outreach Admin"
      # Area: My Cases
      # Area: Management > Configuration

    when "Engagement and Outreach Staff Member"
      # Area: My Cases

    when "Digital Team Staff Member"
      # Area: My Cases

    when "Data Analyst"
      # Area: Case Statistics

    when "Framework Evaluator Admin"
      # Area: Frameworks

    when "Framework Evaluator"
      # Area: Frameworks

    when "CEC Staff Member"
      # Area: My Cases
      # Area: Notifications
      # Area: Find a case

    when "CEC Admin"
      # Area: My Cases
      # Area: Notifications
      # Area: Management > Configuration
      # Area: Email Templates
      # Area: Find a case

    else
      raise ArgumentError, "[FAIL] Role '#{permission}' is not a recognised role in the system"
    end
  end

private

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
    expect(element_present?(cms_top_nav_comps.xpath_link_my_cases)).to be(top_nav_my_cases)

    if top_nav_my_cases
      # Nav to my cases screen
      cms_top_nav_comps.link_my_cases.click
      expect(page).to have_current_path(%r{cases#my-cases}, url: true, wait: 20)
      expect(cms_mycases_page_comps.text_page_heading.text).to include("My cases")

      # Validate the remaining tabs that are only visible of you have the my cases screen
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

  def section_validation_notification_tab(
    notification: false
  )
    # Validate the top page link
    expect(element_present?(cms_top_nav_comps.xpath_link_my_cases)).to be(notification)

    if notification
      # Nav to my notification screen
      cms_top_nav_comps.link_my_cases.click
      expect(page).to have_current_path(%r{support/notifications}, url: true, wait: 20)
      expect(cms_notifications_page_comps.text_page_heading.text).to include("Notifications")
    end
  end

  def section_case_statistics_tabs(
    main_case_statistics: false,
    overview_by_person_tab: false,
    overview_by_stage_tab: false,
    overview_by_category_tab: false
  )
    # Validate the top page link
    expect(element_present?(cms_top_nav_comps.xpath_link_case_statistics)).to be(main_case_statistics)

    if main_case_statistics
      # Nav to my case statistics screen
      cms_top_nav_comps.link_case_statistics.click
      expect(page).to have_current_path(%r{/support/case_statistics#stats-by-person}, url: true, wait: 20)
      expect(cms_case_statistics_comps.text_page_heading.text).to include("Case statistics")

      # Validate the Case Statistics page tabs
      expect(element_present?(cms_case_statistics_comps.xpath_link_overview_by_person)).to be(overview_by_person_tab)
      expect(element_present?(cms_case_statistics_comps.xpath_link_overview_by_stage)).to be(overview_by_stage_tab)
      expect(element_present?(cms_case_statistics_comps.xpath_link_overview_by_category)).to be(overview_by_category_tab)
    end
  end

  def section_validation_management_tab(
    management_page: false
  )
    # Validate the top page link
    expect(element_present?(cms_top_nav_comps.xpath_link_management)).to be(management_page)
    if management_page
      # Validate the top level management tab
      cms_top_nav_comps.link_management.click
      expect(page).to have_current_path(%r{/support/management}, url: true, wait: 20)
      expect(cms_management_comps.text_page_heading.text).to include("CMS Management")
    end
  end

  def validate_management_home_page(
    config_agents: false,
    config_categories: false,
    config_email_templates: false,
    config_energy_for_schools: false,
    tasks_synchronise_frameworks: false,
    tasks_all_cases_survey: false
  )
    expect(element_present?(cms_management_comps.xpath_link_config_agents)).to be(config_agents)
    expect(element_present?(cms_management_comps.xpath_link_config_categories)).to be(config_categories)
    expect(element_present?(cms_management_comps.xpath_link_config_email_templates)).to be(config_email_templates)
    expect(element_present?(cms_management_comps.xpath_link_config_energy_for_schools)).to be(config_energy_for_schools)
    expect(element_present?(cms_management_comps.xpath_link_tasks_sync_frameworks)).to be(tasks_synchronise_frameworks)
    expect(element_present?(cms_management_comps.xpath_link_tasks_sync_all_case_survey)).to be(tasks_all_cases_survey)
  end

  def validate_agents_home_page(
    current_staff_tab: false,
    former_staff_tab: false
  )
    # Open Agents Screen
    cms_management_comps.link_config_agents.click
    expect(page).to have_current_path(%r{/support/management/agents#current-accounts}, url: true, wait: 20)
    expect(cms_agents_list_comps.text_page_heading.text).to include("Agents")

    expect(element_present?(cms_agents_list_comps.xpath_link_current_staff)).to be(current_staff_tab)
    expect(element_present?(cms_agents_list_comps.xpath_link_former_staff)).to be(former_staff_tab)
  end

  def validate_categories_page(
    category: false
  )
    expect(element_present?(cms_management_comps.xpath_link_config_categories)).to be(category)

    # Open Categories screen
    cms_management_comps.link_config_categories.click
    expect(page).to have_current_path(%r{/support/management/categories}, url: true, wait: 20)
    expect(cms_man_categories_list_comps.text_page_heading.text).to include("Categories")
  end

  def validate_email_templates_page(
    email_templates: false
  )
    expect(element_present?(cms_management_comps.xpath_link_config_email_templates)).to be(email_templates)

    # Open Email Templates screen
    cms_management_comps.link_config_email_templates.click
    expect(page).to have_current_path(%r{/support/management/email_templates}, url: true, wait: 20)
    expect(cms_man_email_templates_list_comps.text_page_heading.text).to include("Email templates")
  end

  def validate_energy_for_schools_page(
    energy_for_schools_page: false
  )
    expect(element_present?(cms_management_comps.xpath_link_config_energy_for_schools)).to be(energy_for_schools_page)

    # Open Energy for schools screen
    cms_management_comps.link_config_energy_for_schools.click
    expect(page).to have_current_path(%r{/support/management/energy_for_schools}, url: true, wait: 20)
    expect(cms_man_energy_for_schools_configure_email_comps.text_page_heading.text).to include("Energy for Schools")
  end

  def validate_sycn_framework_page(
    sync_frameworks_page: false
  )
    expect(element_present?(cms_management_comps.xpath_link_tasks_sync_frameworks)).to be(sync_frameworks_page)

    # Open Sync Frameworks screen
    cms_management_comps.link_tasks_sync_frameworks.click
    expect(page).to have_current_path(%r{/support/management/sync_frameworks}, url: true, wait: 20)
    expect(cms_man_sync_framework_comps.text_page_heading.text).to include("Synchronise frameworks")
  end

  def validate_all_cases_survey_page(
    all_surveys_page: false
  )
    expect(element_present?(cms_management_comps.xpath_link_tasks_sync_all_case_survey)).to be(all_surveys_page)

    # Open All cases survey screen
    cms_management_comps.link_tasks_sync_all_case_survey.click
    expect(page).to have_current_path(%r{/support/management/all_cases_surveys}, url: true, wait: 20)
    expect(cms_man_all_cases_survey_comps.text_page_heading.text).to include("Eligible cases")
  end

  def validate_find_a_case_page(
    top_nav_find_a_case_tab: false
  )
    expect(element_present?(cms_top_nav_comps.xpath_link_find_a_case)).to be(top_nav_find_a_case_tab)
    if top_nav_find_a_case_tab
      # Open Find a case screen
      cms_top_nav_comps.link_find_a_case.click
      expect(page).to have_current_path(%r{/support/cases/find-a-case/new}, url: true, wait: 20)
      expect(cms_find_a_case_page_comps.text_page_heading.text).to include("Find a case")
    end
  end

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
      expect(cms_frameworks_register_comps.text_page_heading.text).to include("Find a case")

      # Validate the Frameworks page tabs
      expect(element_present?(cms_frameworks_register_nav_comps.xpath_link_frameworks_register)).to be(sub_frameworks_register)
      expect(element_present?(cms_frameworks_register_nav_comps.xpath_link_framework_evaluations)).to be(sub_framework_evaluations)
      expect(element_present?(cms_frameworks_register_nav_comps.xpath_link_provider_contacts)).to be(sub_provider_contacts)
      expect(element_present?(cms_frameworks_register_nav_comps.xpath_link_providers)).to be(sub_providers)
    end
  end

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
      cms_agents_edit_agent_comps.label_framework_evaluator.set(true)

    when "Framework Evaluator"
      cms_agents_edit_agent_comps.label_framework_evaluator_admin.set(true)

    when "CEC Staff Member"
      cms_agents_edit_agent_comps.label_cec_staff_member.set(true)

    when "CEC Admin"
      cms_agents_edit_agent_comps.label_cec_admin.set(true)
    else
      raise ArgumentError, "permission '#{permission}' is not a role in the system"
    end
  end
end
