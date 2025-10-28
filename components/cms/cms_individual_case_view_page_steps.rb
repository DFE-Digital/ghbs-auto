# frozen_string_literal: true

class CmsIndividualCasePageComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1/label")
  end

  def text_page_heading_case_number
    find(:xpath, "//p[@id='case-ref']/strong")
  end

end
