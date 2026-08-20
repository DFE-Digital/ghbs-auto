# frozen_string_literal: true

class RfhSearchForYourSchoolComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def link_back
    find(:xpath, "//a[text()='Back']")
  end

  def input_organisation_name
    find(:xpath, "//input[@id='framework-support-form-org-id-field']")
  end

  def dropdown_select_org_based_on_ukprn(ukprn)
    find(:xpath, "//ul[@id='framework-support-form-org-id-field__listbox]/li[contains(.,'#{ukprn}')]")
  end

  def button_continue
    find(:xpath, "//input[@value='Continue']")
  end
end
