# frozen_string_literal: true

class CssP3EasyToUseRatingComps
  include Capybara::DSL

  # Page: This service was easy to use
  def text_page_heading
    find(:xpath, "//fieldset/legend")
  end

  def radio_strongly_agree
    find(:xpath, "//input[@id='customer-satisfaction-survey-easy-to-use-rating-strongly-agree-field']/following-sibling::label")
  end

  def radio_agree
    find(:xpath, "//input[@id='customer-satisfaction-survey-easy-to-use-rating-agree-field']/following-sibling::label")
  end

  def radio_neutral
    find(:xpath, "//input[@id='customer-satisfaction-survey-easy-to-use-rating-neutral-field']/following-sibling::label")
  end

  def radio_disagree
    find(:xpath, "//input[@id='customer-satisfaction-survey-easy-to-use-rating-disagree-field']/following-sibling::label")
  end

  def strongly_disagree
    find(:xpath, "//input[@id='customer-satisfaction-survey-easy-to-use-rating-strongly-disagree-field']/following-sibling::label")
  end

  def button_continue
    find(:xpath, "//input[@value='Continue' and @name = 'commit']")
  end

end
