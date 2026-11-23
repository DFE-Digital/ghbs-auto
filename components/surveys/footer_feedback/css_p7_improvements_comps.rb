# frozen_string_literal: true

class CssP7ImprovementsComps
  include Capybara::DSL

  # Page: Please tell us how we could improve this service
  def text_page_heading
    find(:xpath, "//label[@for='customer-satisfaction-survey-improvements-field']")
  end

  def textarea_how_to_improve
    find(:xpath, "//textarea[@id='customer-satisfaction-survey-improvements-field']")
  end

  def button_continue
    find(:xpath, "//input[@value='Continue' and @name = 'commit']")
  end
end
