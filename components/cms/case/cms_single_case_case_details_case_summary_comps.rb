# frozen_string_literal: true

class CmsSingleCaseCaseDetailsCaseSummaryComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def radio_request_type
    find(:xpath, "//input[@id='case-summary-request-type-true-field']/following-sibling::label")
  end

  def dropdown_request_type_sub_category(option)
    find(:xpath, "//select[@id='select_request_details_query_id']/option[text()='#{option}']")
  end

  def input_description_of_query
    find(:xpath, "//textarea[@id='case-summary-request-text-field']")
  end

  def radio_case_level_1
    find(:xpath, "//label[@for='case-summary-support-level-l1-field']")
  end

  def radio_case_level_2
    find(:xpath, "//label[@for='case-summary-support-level-l2-field']")
  end

  def radio_case_level_3
    find(:xpath, "//label[@for='case-summary-support-level-l3-field']")
  end

  def radio_case_level_4
    find(:xpath, "//label[@for='case-summary-support-level-l4-field']")
  end

  def radio_case_level_5
    find(:xpath, "//label[@for='case-summary-support-level-l5-field']")
  end

  def radio_case_level_6
    find(:xpath, "//label[@for='case-summary-support-level-l6-field']")
  end

  def radio_case_level_7
    find(:xpath, "//label[@for='case-summary-support-level-l7-field']")
  end

  def radio_case_level_not_specified
    find(:xpath, "//label[@for='case-summary-support-level-field']")
  end

  def dropdown_stage
    find(:xpath, "TBC")
  end

  def input_case_value_or_estimated_contract_value
    find(:xpath, "//input[@id='case-summary-value-field']")
  end

  def dropdown_case_source
    find(:xpath, "TBC")
  end

  def dropdown_case_project
    find(:xpath, "TBC']") # No data in Dev for this at the moment.
  end

  def input_next_key_date_day
    find(:xpath, "//input[@id='case_summary_next_key_date_3i']")
  end

  def input_next_key_date_month
    find(:xpath, "//input[@id='case_summary_next_key_date_2i']")
  end

  def input_next_key_date_year
    find(:xpath, "//input[@id='case_summary_next_key_date_1i']")
  end

  def input_description_of_next_key_date
    find(:xpath, "//textarea[@id='case-summary-next-key-date-description-field']")
  end

  def button_continue
    find(:xpath, "//button[@name='button' and @value='confirm']")
  end
end
