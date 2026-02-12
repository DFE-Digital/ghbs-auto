# frozen_string_literal: true

require "pages/shared/shared_global_methods"
require "pages/cms/cms_base_page"
require "components/cms/management/cms_management_comps"
require "components/cms/management/cms_man_agents_list_comps"
require "components/cms/management/cms_man_agents_edit_agent_comps"
require "components/cms/management/cms_man_categories_list_comps"
require "components/cms/management/cms_man_email_templates_list_comps"
require "components/cms/management/cms_man_email_templates_edit_comps"
require "components/cms/management/cms_man_energy_for_schools_configure_email_comps"
require "components/cms/management/cms_man_sync_framework_comps"
require "components/cms/management/cms_man_all_cases_survey_comps"
require "components/cms/cms_top_nav_comps"
require "helpers/validation_helpers"
class CmsRbaManagementMethods < CmsBasePage
  include ValidationHelpers

  def section_validation_management_tab(
    management_page: false
  )
    # Validate the top page link
    expect(element_present?(cms_top_nav_comps.xpath_link_management)).to be(management_page)
    if management_page
      # Validate the top level management tab
      cms_top_nav_comps.link_management.click

      if ["Engagement and Outreach Admin", "Engagement and Outreach Staff Member"].include?(current_user_state.role)
        expect(page).to have_current_path(%r{/engagement/management}, url: true, wait: 20)
      elsif ["CEC Staff Member", "CEC Admin"].include?(current_user_state.role)
        expect(page).to have_current_path(%r{/cec/management}, url: true, wait: 20)
      else
        expect(page).to have_current_path(%r{/support/management}, url: true, wait: 20)
      end

      wait_for_element_to_include(cms_management_comps.text_page_heading, "CMS Management", timeout: 5)
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

    if ["Engagement and Outreach Admin", "Engagement and Outreach Staff Member"].include?(current_user_state.role)
      expect(page).to have_current_path(%r{/engagement/management/agents#current-accounts}, url: true, wait: 20)
    elsif ["CEC Staff Member", "CEC Admin"].include?(current_user_state.role)
      expect(page).to have_current_path(%r{/cec/management/agents#current-accounts}, url: true, wait: 20)
    else
      expect(page).to have_current_path(%r{/support/management/agents#current-accounts}, url: true, wait: 20)
    end

    wait_for_element_to_include(cms_agents_list_comps.text_page_heading, "Agents", timeout: 5)

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
    wait_for_element_to_include(cms_man_categories_list_comps.text_page_heading, "Categories", timeout: 5)
  end

  def validate_email_templates_page(
    email_templates: false
  )
    expect(element_present?(cms_management_comps.xpath_link_config_email_templates)).to be(email_templates)

    # Open Email Templates screen
    cms_management_comps.link_config_email_templates.click
    expect(page).to have_current_path(%r{/support/management/email_templates}, url: true, wait: 20)
    wait_for_element_to_include(cms_man_email_templates_list_comps.text_page_heading, "Email templates", timeout: 5)
  end

  def validate_energy_for_schools_page(
    energy_for_schools_page: false
  )
    expect(element_present?(cms_management_comps.xpath_link_config_energy_for_schools)).to be(energy_for_schools_page)

    # Open Energy for schools screen
    cms_management_comps.link_config_energy_for_schools.click
    expect(page).to have_current_path(%r{/support/management/energy_for_schools}, url: true, wait: 20)
    wait_for_element_to_include(cms_man_energy_for_schools_configure_email_comps.text_page_heading, "Energy for Schools", timeout: 5)
  end

  def validate_sycn_framework_page(
    sync_frameworks_page: false
  )
    expect(element_present?(cms_management_comps.xpath_link_tasks_sync_frameworks)).to be(sync_frameworks_page)

    # Open Sync Frameworks screen
    cms_management_comps.link_tasks_sync_frameworks.click
    expect(page).to have_current_path(%r{/support/management/sync_frameworks}, url: true, wait: 20)
    wait_for_element_to_include(cms_man_sync_framework_comps.text_page_heading, "Synchronise frameworks", timeout: 5)
  end

  def validate_all_cases_survey_page(
    all_surveys_page: false
  )
    expect(element_present?(cms_management_comps.xpath_link_tasks_sync_all_case_survey)).to be(all_surveys_page)

    # Open All cases survey screen
    cms_management_comps.link_tasks_sync_all_case_survey.click
    expect(page).to have_current_path(%r{/support/management/all_cases_surveys}, url: true, wait: 20)
    wait_for_element_to_include(cms_man_all_cases_survey_comps.text_page_heading, "Eligible cases", timeout: 5)
  end
end
