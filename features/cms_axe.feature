@cms @selenium-axe
Feature: GHBS - CMS accessibility checks
  Background:
    Given we open and login to the proc ops CMS screens as an admin in the dev environment

  @wip
  Scenario: CORE-110: CMS - Case - Full Evaluation Flow - Accessibility
    Given we create a new case and set it to a level "4" case
    And we assign our current case worker to the case
    When we complete the evaluation flow upto and including the email sending
    And login and complete the school facing evaluation flow as the school user
    Then we confirm the notification to the proc ops user has been sent
    And the ProcOps user will be able to validate school users evaluation

