# frozen_string_literal: true

class CmsSingleCaseResolveCasePageComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//label[@for='case-resolution-form-notes-field']")
  end

  def input_notes
    find(:xpath, "//textarea[@id='case-resolution-form-notes-field']")
  end

  def button_save_and_close_case
    find(:xpath, "//input[@value='Save and close case']")
  end
end
