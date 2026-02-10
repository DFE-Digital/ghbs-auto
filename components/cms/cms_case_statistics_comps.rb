# frozen_string_literal: true

class CmsCaseStatisticsComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//main/h1")
  end

  def xpath_link_overview_by_person
    "//a[contains(.,'Overview by Person')]"
  end

  def link_overview_by_person
    find(:xpath, xpath_link_overview_by_person)
  end

  def xpath_link_overview_by_stage
    "//a[contains(.,'Overview by Stage')]"
  end

  def link_overview_by_stage
    find(:xpath, xpath_link_overview_by_stage)
  end

  def xpath_link_overview_by_category
    "//a[contains(.,'Overview by Category')]"
  end

  def link_overview_by_category
    find(:xpath, xpath_link_overview_by_category)
  end
end
