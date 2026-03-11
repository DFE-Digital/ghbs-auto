@cms @regression
Feature: GHBS - CMS - Case - Tasklist Flows
  Background:
    Given we open and login to the proc ops CMS screens as an admin in the dev environment

  @smoke @wip
  Scenario: ES-1113: CMS - Case States
    Given we create a new case and set it to a level "4" case
    When I complete the case lifecycle actions I will see the status change:
      | action                  | expected_status |
      | Create a new case       | New             |
      | Log contact with school | On Hold         |
#      | Reopen case             | Open            |
#      | Resolve case            | Resolved        |
#      | Reopen case             | Open            |
#      | Reject case             | Closed          |


    # 1. Create new case - New
    # 2. Actions - Log contact with school - On Hold
    # 3. Actions - Reopen case - Open
    # 4. Actions - Resolve Case - Resolved
    # 5. Actions - Reopen case - Open
    # 6. Actions - Reject case - Closed

