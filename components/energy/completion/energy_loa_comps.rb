# frozen_string_literal: true

class EnergyLoaComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  # Agree to the Energy for Schools letter of authority
  def checkbox_1
    find(:xpath, "//input[@id='letter-of-authorisation-form-loa-agreed-agreement1-field']/following-sibling::label")
  end

  def checkbox_2
    find(:xpath, "//input[@id='letter-of-authorisation-form-loa-agreed-agreement2-field']/following-sibling::label")
  end

  def checkbox_3
    find(:xpath, "//input[@id='letter-of-authorisation-form-loa-agreed-agreement3-field']/following-sibling::label")
  end

  # Form completion
  def button_continue
    find(:xpath, "//input[@value='Continue' and @type='submit']")
  end
end
