@framework-register @regression
Feature: GHBS - FABS to CMS - Framework Register Flows

  @smoke
  Scenario: ES-989: Framework Register - FABS to CMS - Update Existing Framework
    Given we are logged in to Contentful with publishing permissions
    When we update the "Auto Test Solution - Please Ignore" frameworks title and content
    And we validate this change has appeared on the Contentful API
    And we open and login to the proc ops CMS screens as an admin in the dev environment
    And trigger the Synchronization job
    Then the changes contentful framework changes will be reflected in the Frameworks Register

  Scenario: ES-1127 - CMS - Framework Register - Categories
    Given we open and login to the proc ops CMS screens as an admin in the dev environment
    When we navigate the Frameworks Register opening the first DfE approved record
    And we add multiple new categories to the framework
    And we remove all same categories from the framework
    Then we will see our framework displays no categories
    And we can leave and return to the framework