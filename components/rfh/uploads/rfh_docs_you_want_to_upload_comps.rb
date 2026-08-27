# frozen_string_literal: true

class RfhDocsYouWantToUploadComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//legend")
  end

  def link_back
    find(:xpath, "//a[text()='Back']")
  end

  def checkbox_current_contract
    find(:xpath, "//input[@id='framework-support-form-document-types-current-contract-field']/following-sibling::label")
  end

  def checkbox_comms_with_your_supplier
    find(:xpath, "//input[@id='framework-support-form-document-types-floor-plans-field']/following-sibling::label")
  end

  def checkbox_floor_plans_or_site_maps
    find(:xpath, "//input[@id='framework-support-form-document-types-floor-plans-field']/following-sibling::label")
  end

  def checkbox_quotes
    find(:xpath, "//input[@id='framework-support-form-document-types-quotes-field']/following-sibling::label")
  end

  def checkbox_specs
    find(:xpath, "//input[@id='framework-support-form-document-types-specifications-field']/following-sibling::label")
  end

  def checkbox_other_please_specify
    find(:xpath, "//input[@id='framework-support-form-document-types-other-field']/following-sibling::label")
  end

  def input_other_please_specify
    find(:xpath, "//input[@id='framework-support-form-document-type-other-field']")
  end

  def checkbox_nothing_to_upload
    find(:xpath, "//input[@id='framework-support-form-document-types-none-field']/following-sibling::label")
  end

  def button_continue
    find(:xpath, "//input[@value='Continue']")
  end
end
