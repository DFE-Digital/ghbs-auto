# frozen_string_literal: true

class RfhIsThisYourContactInfoComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def text_your_name
    find(:xpath, "//dt[contains(.,'Your name')]/following-sibling::dd[1]")
  end

  def text_your_email_address
    find(:xpath, "//dt[contains(.,'Your email address')]/following-sibling::dd[1]")
  end

  def button_yes_continue
    find(:xpath, "//button[contains(.,'Yes, continue')]")
  end
end


