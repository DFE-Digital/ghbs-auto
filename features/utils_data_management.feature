Feature: GHBS - Util - Data management
  Background:
    Given we open and login to the cec screens as an admin in the dev environment

  @close-case-cec
  Scenario: Data Reset Util - Close or Resolve specific case via CEC screens
    Given we find and open case "000144" via the cms find a case screen
    Then we complete the actions to either Close or Resolve the case
