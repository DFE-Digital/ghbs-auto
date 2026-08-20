# frozen_string_literal: true

class RfhIsThisTheSchoolYourBuyingForComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def link_back
    find(:xpath, "//a[text()='Back']")
  end

  def text_name_and_address
    find(:xpath, "//dt[contains(.,'Name and Address')]/following-sibling::dd[1]")
  end

  def text_local_authority
    find(:xpath, "//dt[contains(.,'Local authority')]/following-sibling::dd[1]")
  end

  def text_headteacher_or_principal
    find(:xpath, "//dt[contains(.,'Headteacher')]/following-sibling::dd[1]")
  end

  def text_school_type
    find(:xpath, "//dt[contains(.,'School type')]/following-sibling::dd[1]")
  end

  def text_ids
    find(:xpath, "//dt[contains(.,'IDs')]/following-sibling::dd[1]")
  end

  def text_phase_of_education
    find(:xpath, "//dt[contains(.,'Phase of education')]/following-sibling::dd[1]")
  end

  def radio_yes
    find(:xpath, "//input[@id='framework-support-form-org-confirm-true-field']/following-sibling::label")
  end

  def radio_no_choose_another
    find(:xpath, "//input[@id='framework-support-form-org-confirm-field']/following-sibling::label")
  end

  def button_continue
    find(:xpath, "//input[@value='Continue']")
  end
end
