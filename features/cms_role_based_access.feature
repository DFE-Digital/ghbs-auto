@cms @regression
Feature: GHBS - CMS - Role Based Access
  Background:
    Given we open and login to the proc ops CMS screens as an admin in the dev environment

  Scenario Outline: ES-1120-1 - CMS - RBA - High level functional area and screen flow access validation
    Given we set out "<TargetUser>" to have a role of "<Role>" from the Agents screen
    And we log out and log back in as our "<TargetUser>" who has the role of "<Role>"
    Then we validate that the "<Role>" has the correct access within the cms system
    Examples:
      | TargetUser           | Role                                 |
      | rba_test_user_login  | Global Administrator                 |
      | rba_test_user_login  | Procurement Operations Admin         |
      | rba_test_user_login  | Procurement Operations Staff Member  |
      | rba_test_user_login  | Engagement and Outreach Admin        |
      | rba_test_user_login  | Engagement and Outreach Staff Member |
      | rba_test_user_login  | Digital Team Staff Member            |
      | rba_test_user_login  | Data Analyst                         |
      | rba_test_user_login  | Framework Evaluator Admin            |
      | rba_test_user_login  | Framework Evaluator                  |
      | rba_test_user_login  | CEC Staff Member                     |
      | rba_test_user_login  | CEC Admin                            |

#  Scenario Outline: ES-1120-2 - CMS - RBA - Agents View Permissions
#    Given we set out "<TargetUser>" to have a role of "<Role>" from the Agents screen
#    And we log out and log back in as our "<TargetUser>" who has the role of "<Role>"
#    Then we validate that the "<Role>" has the correct Agents screen permissions
#    Examples:
#      | TargetUser           | Role                                 |
#      | rba_test_user_login  | Global Administrator                 |
#      | rba_test_user_login  | Procurement Operations Admin         |
#      | rba_test_user_login  | Engagement and Outreach Admin        |
#      | rba_test_user_login  | Framework Evaluator Admin            |
#      | rba_test_user_login  | CEC Admin                            |
#

  # Scenario Outline: ES-1120-3 - CMS - RBA - Cases View
  # Scenario Outline: ES-1120-4 - CMS - RBA - Find a Case View


  # Note: The key areas this test will focus on are shown below:
      # Area: My Cases
      # Area: Notifications
      # Area: Case Statistics
      # Area: Management > Configuration
      # Area: Management > Tasks
      # Area: Email Templates
      # Area: Find a case
      # Area: Frameworks