# frozen_string_literal: true

require "pages/cms/cms_base_page"
require "components/cms/case/cms_single_case_nav_comps"
require "components/cms/case/task_list/evaluation/cms_eval_task_list_comps"
require "components/cms/case/task_list/evaluation/add_evaluator/cms_eval_add_evaluators_comps"
require "components/cms/case/task_list/evaluation/add_evaluator/cms_eval_add_evaluator_details_comps"
require "components/cms/case/task_list/evaluation/cms_eval_set_due_date_comps"
require "helpers/validation_helpers"

class CmsCaseEvaluationFlowMethods < CmsBasePage
  include ValidationHelpers
  def complete_initial_eval_setup_proc_ops_side
    # At this point we assume the user has already set the case to a level 4 and has the "Task list" tab available to them
    cms_single_case_nav_comps.link_task_list.click
    expect(page).to have_current_path(%r{/support/cases/}, url: true, wait: 10)
    expect(cms_eval_task_list_comps.text_section_heading.text).to include("Procurement task list")
    expect(cms_eval_task_list_comps.text_evaluation_heading.text).to include("Complete evaluation")

    complete_add_evaluators
    complete_set_due_date
  end

  def complete_add_evaluators
    # Open the "Add evaluators" page
    cms_eval_task_list_comps.link_add_evaluators.click
    wait_for_heading_includes(cms_eval_add_evaluators_comps.text_page_heading, "Evaluators", timeout: 5)

    # Complete the "Add" process to add a new evaluator
    cms_eval_add_evaluators_comps.button_add.click
    wait_for_heading_includes(cms_eval_add_evaluator_details_comps.text_page_heading, "Add evaluator details", timeout: 5)

    user_first_name = "AutoTestEvalFN-#{Time.now.strftime('%S-%M-%H-%m-%d-%Y')}"
    user_last_name = "AutoTestEvalLN"
    cms_eval_add_evaluator_details_comps.input_first_name.set(user_first_name)
    cms_eval_add_evaluator_details_comps.input_last_name.set(user_last_name)
    case_state.case_evaluator_1_email = SECRETS["proc_ops_cms_username"]
    cms_eval_add_evaluator_details_comps.input_email_address.set(case_state.case_evaluator_1_email)

    cms_eval_add_evaluator_details_comps.button_save_changes.click
    wait_for_heading_includes(cms_eval_add_evaluators_comps.text_page_heading, "Evaluators", timeout: 5)

    # Confirm our user has been added
    cms_eval_add_evaluators_comps.text_evaluator_email_address(case_state.case_evaluator_1_email)
    cms_eval_add_evaluators_comps.text_evaluator_name("#{user_first_name} #{user_last_name}")

    # Return to the main menu
    cms_eval_add_evaluators_comps.button_back.click
    expect(page).to have_current_path(%r{/support/cases/}, url: true, wait: 10)
    expect(cms_eval_task_list_comps.text_section_heading.text).to include("Procurement task list")
    expect(cms_eval_task_list_comps.text_evaluation_heading.text).to include("Complete evaluation")
    expect(cms_eval_task_list_comps.text_add_evaluators_status.text).to include("Complete")
  end

  def complete_set_due_date
    # Open the "Set due date" page
    cms_eval_task_list_comps.link_set_due_date.click

    # Complete the "Set due date" process
    wait_for_heading_includes(cms_eval_set_due_date_comps.text_page_heading, "Set due date", timeout: 5)

    # get today's date + 60 days
    future_date = Date.today + 60

    # extract individual parts with leading zeros
    day   = sprintf("%02d", future_date.day)
    month = sprintf("%02d", future_date.month)
    year  = future_date.year.to_s

    # set each field on the page
    cms_eval_set_due_date_comps.input_day.set(day)
    cms_eval_set_due_date_comps.input_month.set(month)
    cms_eval_set_due_date_comps.input_year.set(year)

    # Add to case state
    case_state.case_evaluation_due_date = "#{day}-#{month}-#{year}"

    # Return to the main menu
    cms_eval_set_due_date_comps.button_continue.click
    expect(page).to have_current_path(%r{/support/cases/}, url: true, wait: 10)
    expect(cms_eval_task_list_comps.text_section_heading.text).to include("Procurement task list")
    expect(cms_eval_task_list_comps.text_set_due_date_status.text).to include("Complete")
  end

  def complete_upload_documents
    # TODO
  end

  def complete_email_evaluators
    # TODO
  end

  def complete_review_evaluations
    # TODO
  end
end
