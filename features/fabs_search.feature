Feature: GHBS - FABS homepage navigation
  Background:
    Given we open and validate the fabs homepage

@regression @smoke @fabs
  Scenario: ES-646-2 - Search for Laptop
    Given I search for "laptop" in the main search on the fabs homepage
    Then I am shown the resulting buying options

@forcedFail
  Scenario: ES-12999 - Search failing test to prove our reporting
    Given I search for "fail" in the main search on the fabs homepage
    Then I am shown the resulting buying options