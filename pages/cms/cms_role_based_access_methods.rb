# frozen_string_literal: true

require "pages/shared/shared_global_methods"
require "pages/cms/cms_base_page"
require "pages/cms/cms_top_nav_methods"
require "components/cms/management/cms_management_comps"
require "components/cms/management/cms_agents_list_comps"
require "components/cms/management/cms_agents_edit_agent_comps"
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
