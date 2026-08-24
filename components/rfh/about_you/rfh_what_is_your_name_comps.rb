# frozen_string_literal: true

class RfhWhatIsYourNameComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def link_back
    find(:xpath, "//a[text()='Back']")
  end

  def input_first_name
    find(:xpath, "//input[@id='framework-support-form-first-name-field']")
  end

  def input_last_name
    find(:xpath, "//input[@id='framework-support-form-last-name-field']")
  end

  def button_continue
    find(:xpath, "//input[@value='Continue']")
  end
end
