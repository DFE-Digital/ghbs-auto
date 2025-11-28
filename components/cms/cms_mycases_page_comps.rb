# frozen_string_literal: true

class CmsMyCasesPageComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def button_create_a_new_case
    find(:xpath, "//button[text()='Create a new case']")
  end
end
