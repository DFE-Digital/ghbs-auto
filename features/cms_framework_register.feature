@framework-register
Feature: GHBS - FABS to CMS - Framework Register Flows

  @wip
  Scenario: ES-989: Framework Register - FABS to CMS - Update Existing Framework
    Given we are logged in to Contentful with publishing permissions
    When we update the "Auto Test Solution - Please Ignore" frameworks title and content
    And we validate this change has appeared on the Contentful API
    And we open and login to the proc ops CMS screens as an admin in the dev environment
    And trigger the Synchronization job
    Then the changes to "FrameworkName" will have been reflected in the Frameworks Register
