# frozen_string_literal: true

class EnergyWhichSchoolBuyingForComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def radio_select_desired_school(school_name)
    find(:xpath, "//label[text()='#{school_name}']")
  end

  # Form completion
  def button_continue
    find(:xpath, "//input[@type='submit' and @value='Continue']")
  end
end
