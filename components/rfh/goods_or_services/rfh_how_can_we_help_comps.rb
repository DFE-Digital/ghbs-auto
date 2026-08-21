# frozen_string_literal: true

class RfhHowCanWeHelpComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//label")
  end

  def link_back
    find(:xpath, "//a[text()='Back']")
  end

  def input_info_text
    find(:xpath, "//textarea[@id='framework-support-form-message-body-field']")
  end

  def button_continue
    find(:xpath, "//input[@value='Continue']")
  end
end
