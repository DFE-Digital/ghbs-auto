# frozen_string_literal: true

require "pages/shared/shared_global_methods"
require "pages/surveys/surveys_base_page"
require "components/fabs/fabs_footer_nav_comps"
require "components/surveys/footer_feedback/css_p1_start_comps"
require "components/surveys/footer_feedback/css_p2_satisfaction_level_comps"
require "components/surveys/footer_feedback/css_p3_easy_to_use_rating_comps"
require "components/surveys/footer_feedback/css_p4_helped_how_comps"
require "components/surveys/footer_feedback/css_p5_clear_to_use_rating_comps"
require "components/surveys/footer_feedback/css_p6_recommendation_likelihood_comps"
require "components/surveys/footer_feedback/css_p7_improvements_comps"
require "components/surveys/footer_feedback/css_p8_thank_you_comps"
require "helpers/validation_helpers"
require "helpers/logger_helpers"
require "helpers/unique_content_helpers"

class CssMethods < SurveysBasePage
  include ValidationHelpers
  include LoggerHelpers
  include UniqueContentHelpers

  # CSS: Customer Satisfaction Survey Methods, accessible from the footer of the site

  def navigate_to_start_of_css_feedback_survey
    # Click on the feedback footer link
    fabs_footer_nav_comps.link_feedback.click

    # Confirm we are on the feedback start page aka Get help buying for schools feedback
    expect(page).to have_current_path(%r{/customer_satisfaction_surveys/new\?service=find_a_buying_solution&source=footer_link}, url: true, wait: 10)
    expect(css_p1_start_comps.text_page_heading.text).to include("Get help buying for schools feedback")

    # Continue on to the relevant org selection screen
    css_p1_start_comps.button_continue.click
  end

  def complete_p2_satisfaction_level
    # Confirm we are on the "Overall, how satisfied are you with this service?" page
    expect(page).to have_current_path(%r{/customer_satisfaction_surveys/}, url: true, wait: 10)
    expect(page).to have_current_path(%r{/satisfaction_level/edit}, url: true, wait: 10)
    expect(css_p2_satisfaction_level_comps.text_page_heading.text).to include("Overall, how satisfied are you with this service?")

    # Set the "Neither satisfied nor dissatisfied" option
    css_p2_satisfaction_level_comps.radio_neither_satisfied_nor_dissatisfied.click
    css_p2_satisfaction_level_comps.textarea_neither_satisfied_nor_dissatisfied_why.set("Auto script giving the reason 'why' for the Neither satisfied nor dissatisfied option")

    # Continue on to the relevant org selection screen
    css_p2_satisfaction_level_comps.button_continue.click
  end

  def complete_p3_easy_to_use_rating
    # Confirm we are on the "This service was easy to use" page
    expect(page).to have_current_path(%r{/customer_satisfaction_surveys/}, url: true, wait: 10)
    expect(page).to have_current_path(%r{/easy_to_use_rating/edit}, url: true, wait: 10)
    expect(css_p3_easy_to_use_rating_comps.text_page_heading.text).to include("This service was easy to use")

    # Set the "radio_strongly_agree" option
    css_p3_easy_to_use_rating_comps.radio_strongly_agree.click

    # Continue on to the relevant org selection screen
    css_p3_easy_to_use_rating_comps.button_continue.click
  end

  def complete_p4_helped_how
    # Confirm we are on the "How has this service helped you?" page
    expect(page).to have_current_path(%r{/customer_satisfaction_surveys/}, url: true, wait: 10)
    expect(page).to have_current_path(%r{/helped_how/edit}, url: true, wait: 10)
    expect(css_p4_helped_how_comps.text_page_heading.text).to include("How has this service helped you?")

    # Set the all possible of options
    css_p4_helped_how_comps.checked_saved_me_money.click
    css_p4_helped_how_comps.checked_saved_me_time.click
    css_p4_helped_how_comps.checked_helped_me_to_buy_better_quality_goods_or_services.click
    css_p4_helped_how_comps.checked_improved_my_confidence_to_buy_for_my_school.click
    css_p4_helped_how_comps.checked_improved_my_capability_to_buy_for_my_school.click
    css_p4_helped_how_comps.checked_not_sure.click
    css_p4_helped_how_comps.checked_other.click
    css_p4_helped_how_comps.textarea_other.set("Auto script giving the reason 'how else' for the Other option")

    # Continue on to the relevant org selection screen
    css_p4_helped_how_comps.button_continue.click
  end

  def complete_p5_clear_to_use_ratings
    # TODO css_p5_clear_to_use_rating_comps
  end

  def complete_p6_recommendation_likelihood
    # TODO css_p6_recommendation_likelihood_comps
  end

  def complete_p7_improvements
    # TODO css_p7_improvements_comps
  end

  def complete_p8_thanks
    # TODO css_p7_improvements_comps
  end

end
