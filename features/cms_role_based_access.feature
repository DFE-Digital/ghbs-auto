@cms @regression
Feature: GHBS - CMS - Role Based Access
  Background:
    Given we open and login to the proc ops CMS screens as an admin in the dev environment

  @wip
  Scenario Outline: ES-1120-1 - CMS - RBA - Procurement Operations Admin
    Given we set our "<TargetUser>" to have Procurement Operations Admin from the Agents screen
    And we log out and log back in as our "<TargetUser>"
    Then we validate that the Procurement Operations Admin has the correct access
    Examples:
      | TargetUser           |
      | rba_test_user_login  |

#  Scenario Outline: ES-1120-2 - CMS - RBA - Procurement Operations Staff Member
#    Given we are logged in to the CMS system as a "<LoginUser>" user
#    When we set our "<TargetUser>" to have Procurement Operations Staff Member
#    And we log out as log back in as our "<TargetUser>"
#    Then we validate that the Procurement Operations Staff Member has the correct access
#    Examples:
#      | LoginUser | TargetUser |
#
#  Scenario Outline: ES-1120-3 - CMS - RBA - CEC Staff Member
#    Given we are logged in to the CMS system as a "<LoginUser>" user
#    When we set our "<TargetUser>" to have CEC Staff Member
#    And we log out as log back in as our "<TargetUser>"
#    Then we validate that the CEC Staff Member has the correct access
#    Examples:
#      | LoginUser | TargetUser |
#
#  Scenario Outline: ES-1120-4 - CMS - RBA - CEC Admin
#    Given we are logged in to the CMS system as a "<LoginUser>" user
#    When we set our "<TargetUser>" to have CEC Admin
#    And we log out as log back in as our "<TargetUser>"
#    Then we validate that the CEC Admin has the correct access
#    Examples:
#      | LoginUser | TargetUser |

#  Scenario Outline: ES-1120-5 - CMS - RBA - CEC - Only logic check