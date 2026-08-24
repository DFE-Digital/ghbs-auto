# frozen_string_literal: true

class RfhAccessNeedsComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//legend")
  end

  def link_back
    find(:xpath, "//a[text()='Back']")
  end

  def radio_yes
    find(:xpath, "//input[@id='framework-support-form-special-requirements-choice-yes-field']/following-sibling::label")
  end

  def input_tell_us
    find(:xpath, "//textarea[@id='framework-support-form-special-requirements-field']")
  end

  def radio_no
    find(:xpath, "//input[@id='framework-support-form-special-requirements-choice-no-field']/following-sibling::label")
  end

  def button_continue
    find(:xpath, "//input[@value='Continue']")
  end
end
