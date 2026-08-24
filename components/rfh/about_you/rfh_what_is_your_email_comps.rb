# frozen_string_literal: true

class RfhWhatIsYourEmailComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1/label")
  end

  def link_back
    find(:xpath, "//a[text()='Back']")
  end

  def input_email
    find(:xpath, "//input[@id='framework-support-form-email-field']")
  end

  def button_continue
    find(:xpath, "//input[@value='Continue']")
  end
end
