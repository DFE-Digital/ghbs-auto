# frozen_string_literal: true

class CssP2SatisfactionLevelComps
  include Capybara::DSL

  # Page: Overall, how satisfied are you with this service?
  def text_page_heading
    find(:xpath, "//fieldset/legend")
  end

  # Very satisfied
  def radio_very_satisfied
    find(:xpath, "//input[@id='customer-satisfaction-survey-satisfaction-level-very-satisfied-field']/following-sibling::label")
  end

  def textarea_very_satisfied_why
    find(:xpath, "//textarea[@id='customer-satisfaction-survey-satisfaction-text-very-satisfied-field']")
  end

  # Satisfied
  def radio_satisfied
    find(:xpath, "//input[@id='customer-satisfaction-survey-satisfaction-level-satisfied-field']/following-sibling::label")
  end

  def textarea_satisfied_why
    find(:xpath, "//textarea[@id='customer-satisfaction-survey-satisfaction-text-satisfied-field']")
  end

  # Neither satisfied nor dissatisfied
  def radio_neither_satisfied_nor_dissatisfied
    find(:xpath, "//input[@id='customer-satisfaction-survey-satisfaction-level-neither-field']/following-sibling::label")
  end

  def textarea_neither_satisfied_nor_dissatisfied_why
    find(:xpath, "//textarea[@id='customer-satisfaction-survey-satisfaction-text-neither-field']")
  end

  # Dissatisfied
  def dissatisfied
    find(:xpath, "//input[@id='customer-satisfaction-survey-satisfaction-level-dissatisfied-field']/following-sibling::label")
  end

  def textarea_dissatisfied_why
    find(:xpath, "//textarea[@id='customer-satisfaction-survey-satisfaction-text-dissatisfied-field']")
  end

  # Very dissatisfied
  def very_dissatisfied
    find(:xpath, "//input[@id='customer-satisfaction-survey-satisfaction-level-very-dissatisfied-field']/following-sibling::label")
  end

  def textarea_very_dissatisfied_why
    find(:xpath, "//textarea[@id='customer-satisfaction-survey-satisfaction-text-very-dissatisfied-field']")
  end

  def button_continue
    find(:xpath, "//input[@value='Continue' and @name = 'commit']")
  end

end
