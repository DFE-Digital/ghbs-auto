# frozen_string_literal: true

class CmsSingleCaseCaseDetailsComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//div[@id='case-details']/h2")
  end

  def link_change_case_summary
    find(:xpath, "//h3[contains(.,'Case summary')]/a[text()='change']")
  end

  def text_case_summary_case_level
    find(:xpath, "//dt[contains(.,'Case level')]/following-sibling::dd[1]")
  end

  def link_change_procurement_details
    find(:xpath, "//h3[contains(.,'Procurement details')]/a[text()='change']")
  end

  def link_change_existing_contract_details
    find(:xpath, "//h3[contains(.,'Existing contract details')]/a[text()='change']")
  end

  def link_change_new_contract_details
    find(:xpath, "//h3[contains(.,'New contract details')]/a[text()='change']")
  end

  def link_change_savings_details
    find(:xpath, "//h3[contains(.,'Savings details')]/a[text()='change']")
  end
end
