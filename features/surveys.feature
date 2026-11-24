@regression @fabs
Feature: GHBS - Surveys
  Background:
    Given we open and validate the fabs homepage

  @wip
  Scenario: CORE-760-1: FABS - Customer Satisfaction Survey - Via the footer link
    Given I access the Feedback Survay via the footer link
    And complete the feedback survay screens with standard responses
    #Then I successfully arrive on the Thank you screen




