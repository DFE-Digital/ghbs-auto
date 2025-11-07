# frozen_string_literal: true

class EnergyInfoSubmittedComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  # Agree to the Energy for Schools letter of authority
  def text_case_number
    find(:xpath, "//div[contains(.,'Case reference number')]/strong")
  end

  def link_survay
    find(:xpath, "//a[contains(.,'What did you think of this service?')]")
  end
end
