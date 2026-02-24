@cms @regression @rba
Feature: GHBS - CMS - Role Based Access
  Background:
    Given we open and login to the proc ops CMS screens as an admin in the dev environment

  Scenario Outline: ES-1120 - CMS - RBA - High level functional area and screen flow access validation
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

  Scenario Outline: ES-1179-1 - CMS - RBA - Agents View Permissions
    Given we set out "<TargetUser>" to have a role of "<Role>" from the Agents screen
    And we log out and log back in as our "<TargetUser>" who has the role of "<Role>"
    Then we validate that the current user has the correct Agents screen permissions
    Examples:
      | TargetUser           | Role                                 |
      | rba_test_user_login  | Global Administrator                 |
      | rba_test_user_login  | Procurement Operations Admin         |
      | rba_test_user_login  | Engagement and Outreach Admin        |
      | rba_test_user_login  | CEC Admin                            |

  @wip
  Scenario Outline: ES-1179-2 - CMS - RBA - View cases on Find a Case and MyCase
    Given we set out "<TargetUser>" to have a role of "<Role>" from the Agents screen
    And we log out and log back in as our "<TargetUser>" who has the role of "<Role>"
    Then we validate that the "<Role>" has the correct Find a Case permissions
    #And we validate that the "<Role>" has the correct MyCases permissions
    Examples:
      | TargetUser           | Role                                 |
      | rba_test_user_login  | Global Administrator                 |
      | rba_test_user_login  | Procurement Operations Admin         |
      | rba_test_user_login  | Procurement Operations Staff Member  |
      | rba_test_user_login  | Digital Team Staff Member            |
      | rba_test_user_login  | CEC Staff Member                     |
      | rba_test_user_login  | CEC Admin                            |


# Note: The key areas these tests will focus on are shown below:
  # Area: My Cases
  # Area: Notifications
  # Area: Case Statistics
  # Area: Management > Configuration
  # Area: Management > Configuration > Agents
  # Area: Management > Configuration > Categories
  # Area: Management > Configuration > Email templates
  # Area: Management > Configuration > Energy for Schools
  # Area: Management > Tasks Synchronise frameworks
  # Area: Management > Tasks All Cases Survey
  # Area: Find a case
  # Area: Frameworks
  # Area: Frameworks Management
