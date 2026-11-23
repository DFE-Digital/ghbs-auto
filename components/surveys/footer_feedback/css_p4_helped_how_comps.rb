# frozen_string_literal: true

class CssP4HelpedHowComps
  include Capybara::DSL

  # Page: How has this service helped you?
  def text_page_heading
    find(:xpath, "//fieldset/legend")
  end

  def checked_saved_me_money
    find(:xpath, "//input[@id='customer-satisfaction-survey-helped-how-saved-money-field']/following-sibling::label")
  end

  def checked_saved_me_time
    find(:xpath, "//input[@id='customer-satisfaction-survey-helped-how-saved-time-field']/following-sibling::label")
  end

  def checked_helped_me_to_buy_better_quality_goods_or_services
    find(:xpath, "//input[@id='customer-satisfaction-survey-helped-how-helped-buy-better-quality-goods-services-field']/following-sibling::label")
  end

  def checked_improved_my_confidence_to_buy_for_my_school
    find(:xpath, "//input[@id='customer-satisfaction-survey-helped-how-improved-confidence-field']/following-sibling::label")
  end

  def checked_improved_my_capability_to_buy_for_my_school
    find(:xpath, "//input[@id='customer-satisfaction-survey-helped-how-improved-capability-field']/following-sibling::label")
  end

  def checked_not_sure
    find(:xpath, "//input[@id='customer-satisfaction-survey-helped-how-not-sure-field']/following-sibling::label")
  end

  def checked_none_of_the_above
    find(:xpath, "//input[@id='customer-satisfaction-survey-helped-how-none-field']/following-sibling::label")
  end

  def checked_other
    find(:xpath, "//input[@id='customer-satisfaction-survey-helped-how-other-field']/following-sibling::label")
  end

  def textarea_other
    find(:xpath, "//textarea[@id='customer-satisfaction-survey-helped-how-other-field']")
  end

  def button_continue
    find(:xpath, "//input[@value='Continue' and @name = 'commit']")
  end
end
