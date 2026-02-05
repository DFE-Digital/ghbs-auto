# frozen_string_literal: true

class CmsSingleCaseSchoolDetailsComps
  include Capybara::DSL

  def text_section_heading
    find(:xpath, "//h2[contains(.,'School details')]")
  end

  def text_contact_name
    find(:xpath, "//h2[contains(.,'School details')]/following-sibling::dl//dt[contains(.,'Contact name')]/following-sibling::dd[1]")
  end

  def text_contact_phone
    find(:xpath, "//h2[contains(.,'School details')]/following-sibling::dl//dt[contains(.,'Contact phone')]/following-sibling::dd[1]")
  end

  def text_contact_extension
    find(:xpath, "//h2[contains(.,'School details')]/following-sibling::dl//dt[contains(.,'Contact extension')]/following-sibling::dd[1]")
  end

  def text_contact_email
    find(:xpath, "//h2[contains(.,'School details')]/following-sibling::dl//dt[contains(.,'Contact email')]/following-sibling::dd[1]")
  end

  def text_additional_contacts
    find(:xpath, "//h2[contains(.,'School details')]/following-sibling::dl//dt[contains(.,'Additional contacts')]/following-sibling::dd[1]")
  end

  def text_organisation_name
    find(:xpath, "//h2[contains(.,'School details')]/following-sibling::dl//dt[contains(.,'Organisation name')]/following-sibling::dd[1]")
  end

  def text_organisation_type
    find(:xpath, "//h2[contains(.,'School details')]/following-sibling::dl//dt[contains(.,'Organisation type')]/following-sibling::dd[1]")
  end
end
