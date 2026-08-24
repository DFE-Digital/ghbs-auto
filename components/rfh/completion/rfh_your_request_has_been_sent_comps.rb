# frozen_string_literal: true

class RfhYourRequestHasBeenSentComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//div[@class = 'govuk-panel govuk-panel--confirmation']/h1")
  end

  def text_page_heading_before_you_go
    find(:xpath, "//turbo-frame[@id='end-of-journey-feedback-frame']/h2")
  end

  def link_create_another_request
    find(:xpath, "//a[text()='Create another request']")
  end

  def radio_strongly_agree
    find(:xpath, "//input[@id='end-of-journey-survey-easy-to-use-rating-strongly-agree-field']/following-sibling::label")
  end

  def radio_agree
    find(:xpath, "//input[@id='end-of-journey-survey-easy-to-use-rating-agree-field']/following-sibling::label")
  end

  def radio_neutral
    find(:xpath, "//input[@id='end-of-journey-survey-easy-to-use-rating-neutral-field']/following-sibling::label")
  end

  def radio_disagree
    find(:xpath, "//input[@id='end-of-journey-survey-easy-to-use-rating-disagree-field']/following-sibling::label")
  end

  def radio_strongly_disagree
    find(:xpath, "//input[@id='end-of-journey-survey-easy-to-use-rating-strongly-disagree-field']/following-sibling::label")
  end

  def button_send_feedback
    find(:xpath, "//input[@value='Send feedback']")
  end
end
