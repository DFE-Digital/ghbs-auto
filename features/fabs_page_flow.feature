@regression
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

  @wip
  Scenario: ES-1136-2 - FABS - Complex Breadcumbs page
    Given we navigate to a page that has a complex parent child structure
    And the page will show the breadcrumb parent its associated with
    When we then access the same page from a none parent page
    Then the page will show the origional breadcrumb parent its associated with