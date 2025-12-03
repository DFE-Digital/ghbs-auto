# frozen_string_literal: true

class CmsCreateANewCaseCheckAnswersComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def text_organisation_name
    find(:xpath, "//dt[contains(.,'Organisation name')]/following-sibling::dd[1]")
  end

  def text_organisation_postcode
    find(:xpath, "//dt[contains(.,'Organisation postcode')]/following-sibling::dd[1]")
  end

  def text_organisation_urn
    find(:xpath, "//dt[contains(.,'Organisation URN')]/following-sibling::dd[1]")
  end

  def text_organisation_ukprn
    find(:xpath, "//dt[contains(.,'Organisation UKPRN')]/following-sibling::dd[1]")
  end

  def text_contact_name
    find(:xpath, "//dt[contains(.,'Contact name')]/following-sibling::dd[1]")
  end

  def text_contact_email
    find(:xpath, "//dt[contains(.,'Contact email')]/following-sibling::dd[1]")
  end

  def text_contact_phone_number
    find(:xpath, "//dt[contains(.,'Contact phone number')]/following-sibling::dd[1]")
  end

  def text_contact_extension_number
    find(:xpath, "//dt[contains(.,'Contact extension number')]/following-sibling::dd[1]")
  end

  def text_origin
    find(:xpath, "//dt[contains(.,'Origin')]/following-sibling::dd[1]")
  end

  def text_case_source
    find(:xpath, "//dt[contains(.,'Case source')]/following-sibling::dd[1]")
  end

  def text_request_type
    find(:xpath, "//dt[contains(.,'Type')]/following-sibling::dd[1]")
  end

  def text_procurement_sub_category
    find(:xpath, "//dt[contains(.,'Procurement sub-category')]/following-sibling::dd[1]")
  end

  def text_summary
    find(:xpath, "//dt[contains(.,'Summary')]/following-sibling::dd[1]")
  end

  def text_procurement_value
    find(:xpath, "//dt[contains(.,'Procurement value')]/following-sibling::dd[1]")
  end

  def button_create_case
    find(:xpath, "//button[contains(.,'Create case')]")
  end
end
