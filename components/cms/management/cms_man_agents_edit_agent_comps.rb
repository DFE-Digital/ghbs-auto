# frozen_string_literal: true

class CmsManAgentsEditAgentComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//main/h2")
  end

  def input_first_name
    find(:xpath, "//input[@id='agent-first-name-field']")
  end

  def input_last_name
    find(:xpath, "//input[@id='agent-last-name-field']")
  end

  def text_email_address
    find(:xpath, "//input[@id='agent-email-field']")
  end

  def label_global_administrator
    find(:xpath, "//label[normalize-space()='Global Administrator']")
  end

  def checkbox_global_administrator
    label_global_administrator.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_procurement_operations_admin
    find(:xpath, "//label[normalize-space()='Procurement Operations Admin']")
  end

  def checkbox_procurement_operations_admin
    label_procurement_operations_admin.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_procurement_operations_staff_member
    find(:xpath, "//label[normalize-space()='Procurement Operations Staff Member']")
  end

  def checkbox_procurement_operations_staff_member
    label_procurement_operations_staff_member.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_engagement_and_outreach_admin
    find(:xpath, "//label[normalize-space()='Engagement and Outreach Admin']")
  end

  def checkbox_engagement_and_outreach_admin
    label_engagement_and_outreach_admin.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_engagement_and_outreach_staff_member
    find(:xpath, "//label[normalize-space()='Engagement and Outreach Staff Member']")
  end

  def checkbox_engagement_and_outreach_staff_member
    label_engagement_and_outreach_staff_member.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_digital_team_staff_member
    find(:xpath, "//label[normalize-space()='Digital Team Staff Member']")
  end

  def checkbox_digital_team_staff_member
    label_digital_team_staff_member.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_data_analyst
    find(:xpath, "//label[normalize-space()='Data Analyst']")
  end

  def checkbox_data_analyst
    label_data_analyst.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_framework_evaluator
    find(:xpath, "//label[normalize-space()='Framework Evaluator']")
  end

  def checkbox_framework_evaluator
    label_framework_evaluator.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_framework_evaluator_admin
    find(:xpath, "//label[normalize-space()='Framework Evaluator Admin']")
  end

  def checkbox_framework_evaluator_admin
    label_framework_evaluator_admin.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_cec_staff_member
    find(:xpath, "//label[normalize-space()='CEC Staff Member']")
  end

  def checkbox_cec_staff_member
    label_cec_staff_member.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def label_cec_admin
    find(:xpath, "//label[normalize-space()='CEC Admin']")
  end

  def checkbox_cec_admin
    label_cec_admin.find(:xpath, "./preceding-sibling::input[@type='checkbox']", visible: :all)
  end

  def checkbox_label_pairs
    [
      %i[checkbox_global_administrator label_global_administrator],
      %i[checkbox_procurement_operations_admin label_procurement_operations_admin],
      %i[checkbox_procurement_operations_staff_member label_procurement_operations_staff_member],
      %i[checkbox_engagement_and_outreach_admin label_engagement_and_outreach_admin],
      %i[checkbox_engagement_and_outreach_staff_member label_engagement_and_outreach_staff_member],
      %i[checkbox_digital_team_staff_member label_digital_team_staff_member],
      %i[checkbox_data_analyst label_data_analyst],
      %i[checkbox_framework_evaluator label_framework_evaluator],
      %i[checkbox_framework_evaluator_admin label_framework_evaluator_admin],
      %i[checkbox_cec_staff_member label_cec_staff_member],
      %i[checkbox_cec_admin label_cec_admin],
    ]
  end

  def button_save
    find(:xpath, "//input[@value='Save']", visible: :all)
  end

  def button_cancel
    find(:xpath, "//a[text()='Cancel']", visible: :all)
  end
end
