@selenium-axe @fabs
Feature: GHBS - FABS page accessibility checks
  Background:
    Given we open and validate the fabs homepage
    And we enable the selenium axe checks on each page

  Scenario: ES-669 - Check core pages are WCAG 2.1 AA valid
    Given I validate the footer pages are loading correctly
    And I validate the category flow pages are loading correctly
    And I validate the search and buying option pages are loading correctly
    Then finally I validate the error pages are loading correctly

  # Scenario: example of pure selenium axe built in step
  # Then the page should be axe clean according to: wcag2a, wcag2aa