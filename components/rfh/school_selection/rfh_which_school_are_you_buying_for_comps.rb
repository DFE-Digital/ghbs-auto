# frozen_string_literal: true

class RfhWhichSchoolAreYouBuyingForComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//legend")
  end

  def link_back
    find(:xpath, "//a[text()='Back']")
  end

  def radio_org_name(org_name)
    find(:xpath, "//label[contains(.,'#{org_name}')]")
  end

  def button_continue
    find(:xpath, "//input[@value='Continue']")
  end
end
