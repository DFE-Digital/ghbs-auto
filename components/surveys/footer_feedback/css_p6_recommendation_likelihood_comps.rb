# frozen_string_literal: true

class CssP6RecommendationLikelihoodComps
  include Capybara::DSL

  # Page: On a scale of 0 to 10, how likely are you to recommend us to a colleague?
  def text_page_heading
    find(:xpath, "//fieldset/legend")
  end

  def radio_strongly_agree(zero_to_ten)
    find(:xpath, "//input[@id='customer-satisfaction-survey-recommendation-likelihood-#{zero_to_ten}-field']/following-sibling::label")
  end

  def button_continue
    find(:xpath, "//input[@value='Continue' and @name = 'commit']")
  end
end
