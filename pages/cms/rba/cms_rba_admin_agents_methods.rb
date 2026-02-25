# frozen_string_literal: true

require "pages/shared/shared_global_methods"
require "pages/cms/cms_base_page"
require "pages/cms/cms_top_nav_methods"
require "components/cms/management/cms_management_comps"
require "components/cms/management/cms_man_agents_list_comps"
require "components/cms/management/cms_man_agents_edit_agent_comps"
require "helpers/validation_helpers"

class CmsRbaAdminAgentsMethods < CmsBasePage
  include ValidationHelpers

  def open_and_validate_new_agents_list
    # Move to the 'Add new agent' screen
    cms_man_agents_list_comps.link_new_agent.click
    expect(page).to have_current_path(%r{#{current_user_state.base_url}/management/agents/new}, url: true, wait: 10)
    expect(cms_man_agents_edit_agent_comps.text_page_heading.text).to include("Add new agent")

    # Validate the expected selectable roles
    case current_user_state.role
    when "Global Administrator"
      validate_role_visibility(
        visible_global_administrator: true,
        visible_procurement_operations_admin: true,
        visible_procurement_operations_staff_member: true,
        visible_engagement_and_outreach_admin: true,
        visible_engagement_and_outreach_staff_member: true,
        visible_digital_team_staff_member: true,
        visible_data_analyst: true,
        visible_framework_evaluator: true,
        visible_framework_evaluator_admin: true,
        visible_cec_staff_member: true,
        visible_cec_admin: true
      )

    when "Procurement Operations Admin"
      validate_role_visibility(
        visible_global_administrator: false,
        visible_procurement_operations_admin: true,
        visible_procurement_operations_staff_member: true,
        visible_engagement_and_outreach_admin: false,
        visible_engagement_and_outreach_staff_member: false,
        visible_digital_team_staff_member: false,
        visible_data_analyst: false,
        visible_framework_evaluator: false,
        visible_framework_evaluator_admin: false,
        visible_cec_staff_member: true,
        visible_cec_admin: true
      )

    when "Engagement and Outreach Admin"
      validate_role_visibility(
        visible_global_administrator: false,
        visible_procurement_operations_admin: false,
        visible_procurement_operations_staff_member: false,
        visible_engagement_and_outreach_admin: true,
        visible_engagement_and_outreach_staff_member: true,
        visible_digital_team_staff_member: false,
        visible_data_analyst: false,
        visible_framework_evaluator: false,
        visible_framework_evaluator_admin: false,
        visible_cec_staff_member: false,
        visible_cec_admin: false
      )

    when "CEC Admin"
      validate_role_visibility(
        visible_global_administrator: false,
        visible_procurement_operations_admin: false,
        visible_procurement_operations_staff_member: false,
        visible_engagement_and_outreach_admin: false,
        visible_engagement_and_outreach_staff_member: false,
        visible_digital_team_staff_member: false,
        visible_data_analyst: false,
        visible_framework_evaluator: false,
        visible_framework_evaluator_admin: false,
        visible_cec_staff_member: true,
        visible_cec_admin: true
      )

    else
      raise ArgumentError, "Role '#{current_user_state.role}' is not a role we think should have agent permissions"
    end
  end

private

  def validate_role_visibility(
    visible_global_administrator: false,
    visible_procurement_operations_admin: false,
    visible_procurement_operations_staff_member: false,
    visible_engagement_and_outreach_admin: false,
    visible_engagement_and_outreach_staff_member: false,
    visible_digital_team_staff_member: false,
    visible_data_analyst: false,
    visible_framework_evaluator: false,
    visible_framework_evaluator_admin: false,
    visible_cec_staff_member: false,
    visible_cec_admin: false
  )
    expect(element_present?(cms_man_agents_edit_agent_comps.xpath_label_global_administrator)).to be(visible_global_administrator)
    expect(element_present?(cms_man_agents_edit_agent_comps.xpath_label_procurement_operations_admin)).to be(visible_procurement_operations_admin)
    expect(element_present?(cms_man_agents_edit_agent_comps.xpath_label_procurement_operations_staff_member)).to be(visible_procurement_operations_staff_member)
    expect(element_present?(cms_man_agents_edit_agent_comps.xpath_label_engagement_and_outreach_admin)).to be(visible_engagement_and_outreach_admin)
    expect(element_present?(cms_man_agents_edit_agent_comps.xpath_label_engagement_and_outreach_staff_member)).to be(visible_engagement_and_outreach_staff_member)
    expect(element_present?(cms_man_agents_edit_agent_comps.xpath_label_digital_team_staff_member)).to be(visible_digital_team_staff_member)
    expect(element_present?(cms_man_agents_edit_agent_comps.xpath_label_data_analyst)).to be(visible_data_analyst)
    expect(element_present?(cms_man_agents_edit_agent_comps.xpath_label_framework_evaluator)).to be(visible_framework_evaluator)
    expect(element_present?(cms_man_agents_edit_agent_comps.xpath_label_framework_evaluator_admin)).to be(visible_framework_evaluator_admin)
    expect(element_present?(cms_man_agents_edit_agent_comps.xpath_label_cec_staff_member)).to be(visible_cec_staff_member)
    expect(element_present?(cms_man_agents_edit_agent_comps.xpath_label_cec_admin)).to be(visible_cec_admin)
  end
end
