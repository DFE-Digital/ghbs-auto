# frozen_string_literal: true

class CmsCreateANewCaseComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def input_organisation_name
    find(:xpath, "//input[@name='case_request[organisation_name]']")
  end

  def dropdown_select_org_based_on_ukprn(ukprn)
    find(:xpath, "//ul[@id='school-urn-autocomplete__listbox']/li[contains(.,'#{ukprn}')]")
  end

  def input_contact_first_name
    find(:xpath, "//input[@name='case_request[first_name]']")
  end

  def input_contact_last_name
    find(:xpath, "//input[@name='case_request[last_name]']")
  end

  def input_contact_email
    find(:xpath, "//input[@name='case_request[email]']")
  end

  def input_contact_phone_number
    find(:xpath, "//input[@name='case_request[phone_number]']")
  end

  def input_contact_extension_number
    find(:xpath, "//input[@name='case_request[extension_number]']")
  end

  def radio_case_origin_used_this_service_before
    find(:xpath, "//input[@id='case-request-discovery-method-0-field']/following-sibling::label")
  end

  def radio_case_origin_meeting_or_event
    find(:xpath, "//input[@id='case-request-discovery-method-1-field']/following-sibling::label")
  end

  def radio_case_origin_dfe_publication
    find(:xpath, "//input[@id='case-request-discovery-method-2-field']/following-sibling::label")
  end

  def radio_case_origin_non_dfe_newsletter
    find(:xpath, "//input[@id='case-request-discovery-method-3-field']/following-sibling::label")
  end

  def radio_case_origin_recommendation
    find(:xpath, "//input[@id='case-request-discovery-method-4-field']/following-sibling::label")
  end

  def radio_case_origin_search_engine
    find(:xpath, "//input[@id='case-request-discovery-method-5-field']/following-sibling::label")
  end

  def radio_case_origin_social_media
    find(:xpath, "//input[@id='case-request-discovery-method-6-field']/following-sibling::label")
  end

  def radio_case_origin_website
    find(:xpath, "//input[@id='case-request-discovery-method-7-field']/following-sibling::label")
  end

  def radio_case_origin_other
    find(:xpath, "//input[@id='case-request-discovery-method-8-field']/following-sibling::label")
  end

  def input_case_origin_other
    find(:xpath, "//input[@id='discovery_method_other_text']")
  end

  def radio_request_type_procurement
    find(:xpath, "//input[@id='case-request-request-type-true-field']/following-sibling::label")
  end

  def dropdown_request_type_procurement
    find(:xpath, "//select[@id='select_request_details_category_id']/optgroup/option[text()='Books']")
  end

  def radio_request_type_non_procurement
    find(:xpath, "//input[@id='case-request-request-type-field']/following-sibling::label")
  end

  def dropdown_request_type_non_procurement
    find(:xpath, "//select[@id='select_request_details_query_id']/option[text()='Legal']")
  end

  def input_description_of_query
    find(:xpath, "//textarea[@id='case-request-request-text-field']")
  end

  def input_procurement_value
    find(:xpath, "//input[@id='case-request-procurement-amount-field']")
  end

  def dropdown_case_source
    find(:xpath, "//select[@id='case-request-source-field']/option[text()='Schools Commercial Team (SCT)']")
  end

  def button_save_and_continue
    find(:xpath, "//input[@value='Save and continue']")
  end
end
