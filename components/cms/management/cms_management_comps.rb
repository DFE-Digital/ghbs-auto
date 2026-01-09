# frozen_string_literal: true

class CmsManagementComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def link_config_agents
    find(:xpath, "//a[text()='Agents']")
  end

  def link_config_categories
    find(:xpath, "//a[text()='Categories']")
  end

  def link_config_email_templates
    find(:xpath, "//a[text()='Email templates']")
  end

  def link_config_energy_for_schools
    find(:xpath, "//a[text()='Energy for Schools']")
  end

  def link_tasks_sync_frameworks
    find(:xpath, "//a[text()='Synchronise frameworks']")
  end

  def link_tasks_sync_all_case_survey
    find(:xpath, "//a[text()='All Cases Survey']")
  end

end
