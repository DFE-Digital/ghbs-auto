# frozen_string_literal: true

class CmsSingleCaseCaseDetailsCaseSummaryCheckAnswersComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//main[@id='main-content']/h2")
  end

  def text_sub_category
    find(:xpath, "//dt[contains(.,'Sub-category')]/following-sibling::dd[1]")
  end

  def text_description_of_query
    find(:xpath, "//dt[contains(.,'Description of query')]/following-sibling::dd[1]")
  end

  def text_case_level
    find(:xpath, "//dt[contains(.,'Case level')]/following-sibling::dd[1]")
  end

  def text_stage
    find(:xpath, "//dt[contains(.,'Stage')]/following-sibling::dd[1]")
  end

  def text_case_value
    find(:xpath, "//dt[contains(.,'Case value')]/following-sibling::dd[1]")
  end

  def text_source
    find(:xpath, "//dt[contains(.,'Source')]/following-sibling::dd[1]")
  end

  def text_project
    find(:xpath, "//dt[contains(.,'Project')]/following-sibling::dd[1]")
  end

  def text_next_key_date
    find(:xpath, "//dt[contains(.,'Next key date')]/following-sibling::dd[1]")
  end

  def text_description_of_next_key_date
    find(:xpath, "//dt[contains(.,'Description of next key date')]/following-sibling::dd[1]")
  end

  def button_save
    find(:xpath, "//input[@name='commit' and @value='Save']")
  end
end
