# frozen_string_literal: true

class RfhSendYourRequestComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def link_back
    find(:xpath, "//a[text()='Back']")
  end

  def text_your_name
    find(:xpath, "//dt[contains(.,'Your name')]/following-sibling::dd[1]")
  end

  def text_your_email_address
    find(:xpath, "//dt[contains(.,'Your email address')]/following-sibling::dd[1]")
  end

  def text_your_school
    find(:xpath, "//dt[contains(.,'Your school')]/following-sibling::dd[1]")
  end

  def text_school_type
    find(:xpath, "//dt[contains(.,'School type')]/following-sibling::dd[1]")
  end

  def text_type_of_goods_or_service
    find(:xpath, "//dt[contains(.,'Type of goods or service')]/following-sibling::dd[1]")
  end

  def text_procurement_amount
    find(:xpath, "//dt[contains(.,'Procurement amount')]/following-sibling::dd[1]")
  end

  def text_description_of_request
    find(:xpath, "//dt[contains(.,'Description of request')]/following-sibling::dd[1]")
  end

  def text_accessibility
    find(:xpath, "//dt[contains(.,'Accessibility')]/following-sibling::dd[1]")
  end

  def text_origin
    find(:xpath, "//dt[contains(.,'Origin')]/following-sibling::dd[1]")
  end

  def button_continue
    find(:xpath, "//input[@value='Continue']")
  end
end
