# frozen_string_literal: true

require "pages/shared/shared_global_methods"
require "pages/surveys/surveys_base_page"
require "components/fabs/fabs_footer_nav_comps"
require "components/surveys/footer_feedback/css_p1_start_comps"
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

    # Confirm we are on feedback start page
    expect(page).to have_current_path(%r{/customer_satisfaction_surveys/new\?service=find_a_buying_solution&source=footer_link}, url: true, wait: 10)
    expect(css_p1_start_comps.text_page_heading.text).to include("Get help buying for schools feedback")

    # Continue on to the relevant org selection screen
    css_p1_start_comps.button_continue.click
  end

  def complete_p2_satisfaction_level
    # TODO
  end

  def complete_p3_easy_to_use_rating
    # TODO
  end

  def complete_p4_helped_how
    # TODO
  end

  def complete_p5_clear_to_use_ratings
    # TODO
  end

  def complete_p6_recommendation_likelihood
    # TODO
  end

  def complete_p7_improvements
    # TODO
  end

  def complete_p8_thanks
    # TODO
  end

end
