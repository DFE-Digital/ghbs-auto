# frozen_string_literal: true

class CmsManagementComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def xpath_link_config_agents
    "//a[text()='Agents']"
  end

  def link_config_agents
    find(:xpath, xpath_link_config_agents)
  end

  def xpath_link_config_categories
    "//a[text()='Categories']"
  end

  def link_config_categories
    find(:xpath, xpath_link_config_categories)
  end

  def xpath_link_config_email_templates
    "//a[text()='Email templates']"
  end

  def link_config_email_templates
    find(:xpath, xpath_link_config_email_templates)
  end

  def xpath_link_config_energy_for_schools
    "//a[text()='Energy for Schools']"
  end

  def link_config_energy_for_schools
    find(:xpath, xpath_link_config_energy_for_schools)
  end

  def xpath_link_tasks_sync_frameworks
    "//a[text()='Synchronise frameworks']"
  end

  def link_tasks_sync_frameworks
    find(:xpath, xpath_link_tasks_sync_frameworks)
  end

  def xpath_link_tasks_sync_all_case_survey
    "//a[text()='All Cases Survey']"
  end

  def link_tasks_sync_all_case_survey
    find(:xpath, xpath_link_tasks_sync_all_case_survey)
  end
end
