Feature: GHBS - RFH - Core Flows
  Background:
    Given we ensure we are in a completely browser between tests
    And we open and validate the fabs homepage
    And we navigate to the RFH start page

  @wip
  Scenario: CORE-747: RFH - Flow 1 - Not Signed In - Single School - Goods
    Given I complete the RFH login as a user type of "unverified"
    #And I select a school with the type of "Single School"
    #When I confirm I have a need for "goods" and complete the associated flow
    #And I handle any associated document uploads for the RFH
    #And I verify the data is correct on the final "Send your request" screen
    #Then I successfully arrive on the "Request sent" screen
