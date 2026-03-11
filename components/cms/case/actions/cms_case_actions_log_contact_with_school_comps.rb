# frozen_string_literal: true

class CmsCaseActionsLogContactWithSchoolComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//form/h1")
  end

  def radio_phone_call
    find(:xpath, "//input[@id='interaction-event-type-phone-call-field']/following-sibling::label")
  end

  def radio_email_from_school
    find(:xpath, "//input[@id='interaction-event-type-email-from-school-field']/following-sibling::label")
  end

  def radio_email_to_school
    find(:xpath, "//input[@id='interaction-event-type-email-to-school-field']/following-sibling::label")
  end

  def radio_case_organisation_changed
    find(:xpath, "//input[@id='interaction-event-type-case-organisation-changed-field']/following-sibling::label")
  end

  def radio_case_contact_changed
    find(:xpath, "//input[@id='interaction-event-type-case-contact-changed-field']/following-sibling::label")
  end

  def radio_case_level_changed
    find(:xpath, "//input[@id='interaction-event-type-case-level-changed-field']/following-sibling::label")
  end

  def radio_case_with_school_changed
    find(:xpath, "//input[@id='interaction-event-type-case-with-school-changed-field']/following-sibling::label")
  end

  def input_contact_details
    find(:xpath, "//textarea[@id='interaction_body']")
  end

  def button_save
    find(:xpath, "//input[@value='Save']")
  end
end
