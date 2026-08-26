# frozen_string_literal: true

class RfhAreTheseTheSchoolsYourBuyingForComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def link_back
    find(:xpath, "//a[text()='Back']")
  end

  def text_school_name
    find(:xpath, "//table[@aria-label='Schools to confirm']/tbody[1]//tr[1]//th[1]")
  end

  def text_address
    find(:xpath, "//table[@aria-label='Schools to confirm']/tbody[1]//tr[1]//td[1]")
  end

  def text_phase_of_education
    find(:xpath, "//table[@aria-label='Schools to confirm']/tbody[1]//tr[1]//td[2]")
  end

  def text_local_authority
    find(:xpath, "//table[@aria-label='Schools to confirm']/tbody[1]//tr[1]//td[3]")
  end

  def radio_yes
    find(:xpath, "//input[@id='framework-support-form-school-urns-confirmed-true-field']/following-sibling::label")
  end

  def radio_no_change
    find(:xpath, "//input[@id='framework-support-form-school-urns-confirmed-field']/following-sibling::label")
  end

  def button_continue
    find(:xpath, "//input[@value='Continue']")
  end
end
