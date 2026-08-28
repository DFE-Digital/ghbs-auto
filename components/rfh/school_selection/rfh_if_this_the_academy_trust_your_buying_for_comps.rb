# frozen_string_literal: true

class RfhIfThisTheAcademyTrustYourBuyingForComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def link_back
    find(:xpath, "//a[text()='Back']")
  end

  def text_group_name
    find(:xpath, "//dt[contains(.,'Group name')]/following-sibling::dd[1]")
  end

  def text_address
    find(:xpath, "//dt[contains(.,'Address')]/following-sibling::dd[1]")
  end

  def text_group_type
    find(:xpath, "//dt[contains(.,'Group type')]/following-sibling::dd[1]")
  end

  def text_ids
    find(:xpath, "//dt[contains(.,'IDs')]/following-sibling::dd[1]")
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
