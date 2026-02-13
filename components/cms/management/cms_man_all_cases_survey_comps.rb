# frozen_string_literal: true

class CmsManAllCasesSurveyComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//label[@for='eligible-cases-form-eligible-cases-field']")
  end
end
