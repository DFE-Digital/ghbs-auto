@rfh @regression @smoke
Feature: GHBS - RFH - Core Flows
  Background:
    Given we ensure we are in a completely browser between tests
    And we open and validate the fabs homepage
    And we navigate to the RFH start page

  Scenario: CORE-747: RFH - Flow 1 - Not Signed In - Single School - Goods
    Given I complete the RFH login as a user type of "unverified"
    And I select a school with the type of "Single School"
    When I confirm I have a need for "goods" and complete the associated flow
    And I complete the remaining screens up to and including the Send your request screen
    Then I successfully arrive on the Request sent screen
  @wip
  Scenario: CORE-748: RFH - Flow 2 - Not Signed In - MAT - Service (None Energy)
    Given I complete the RFH login as a user type of "unverified"
    And I select a school with the type of "Multi School"
    When I confirm I have a need for "service" and complete the associated flow
    # And I complete the remaining screens up to and including the Send your request screen
    # Then I successfully arrive on the Request sent screen
