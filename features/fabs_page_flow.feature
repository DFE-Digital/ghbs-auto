@regression @fabs
Feature: GHBS - FABS page behaviour
  Background:
    Given we open and validate the fabs homepage

  @smoke
  Scenario: ES-646-1 - Check core pages are loading as expected
    Given I validate the footer pages are loading correctly
    And I validate the category flow pages are loading correctly
    And I validate the search and buying option pages are loading correctly
    Then finally I validate the error pages are loading correctly

  Scenario: ES-1136-1 - FABS - Simple Breadcrumbs page
    Given we navigate to a simple Buying option via a buying category
    Then the buying category will show the breadcrumbs associated with a simple view

  Scenario: ES-1136-2 - FABS - Complex Breadcrumbs page
    Given we navigate to a complex Buying option via its assigned parent a buying category
    And the buying option will show the breadcrumbs associated with its assigned parent
    When we then access the same page from a none parent page
    Then the page will show the none parent breadcrumb its associated with