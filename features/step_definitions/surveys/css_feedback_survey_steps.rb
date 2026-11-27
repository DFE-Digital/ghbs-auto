# frozen_string_literal: true

Given(/^I access the Feedback Survey via the footer link$/) do
  css_methods.navigate_to_start_of_css_feedback_survey
end

And(/^complete the feedback survey screens with standard responses$/) do
  css_methods.complete_p2_satisfaction_level
  css_methods.complete_p3_easy_to_use_rating
  css_methods.complete_p4_helped_how
  css_methods.complete_p5_clear_to_use_ratings
  css_methods.complete_p6_recommendation_likelihood
  css_methods.complete_p7_improvements
end
