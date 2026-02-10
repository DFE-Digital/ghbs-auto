# frozen_string_literal: true

class CmsAgentsListComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def xpath_link_current_staff
    "//a[contains(.,'Current staff')]"
  end

  def link_current_staff
    find(:xpath, xpath_link_current_staff)
  end

  def xpath_link_former_staff
    "//a[contains(.,'Former staff')]"
  end

  def link_former_staff
    find(:xpath, xpath_link_former_staff)
  end

  def link_edit_by_name(agent_name)
    find(:xpath, "//th[contains(.,'#{agent_name}')]/following-sibling::td[2]/a[contains(.,'Edit')]")
  end

  def link_remove_by_name(agent_name)
    find(:xpath, "//th[contains(.,'#{agent_name}')]/following-sibling::td[2]/a[contains(.,'Remove')]")
  end

  def text_see_roles_by_name(agent_name)
    find(:xpath, "//th[contains(.,'#{agent_name}')]/following-sibling::td[1]")
  end
end
