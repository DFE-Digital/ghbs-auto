@wip
Feature: GHBS - FABS homepage navigation
  Background:
    Given we open and validate the fabs homepage

  Scenario: Search for Laptop
    Given I search for "laptop" in to the main search on the fabs homepage
    Then I am shown the resulting buying options
