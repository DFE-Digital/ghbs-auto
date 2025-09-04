@regression @smoke @wip
Feature: GHBS - FABS page load checker
  Background:
    Given we open and validate the fabs homepage

  Scenario: Check core pages are loading as expected
    Given I validate the footer pages are loading correctly
    And I validate the category flow pages are loading correctly
    And I validate the search and buying option pages are loading correctly
    Then finally I validate the error pages are loading correctly
