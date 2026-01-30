# frozen_string_literal: true

class FabsSavingsOptionsForSchoolsComps
  include Capybara::DSL

  # Text
  def text_page_heading
    find(:xpath, "//h1")
  end

  # Inputs
  def link_find_out_more_about_insignis
    find(:xpath, "//a[text()='Find out more about Insignis (opens in new tab)']")
  end

end
