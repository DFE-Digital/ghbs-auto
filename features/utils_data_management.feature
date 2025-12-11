Feature: GHBS - Util - Data management
  Background:
    Given we open and login to the proc ops CMS screens as an admin in the dev environment

  Scenario: Data Reset Util 01 - Close or Resolve specific case via CEC screens
    Given we find and open case "000630" via the cms find a case screen
    Then we complete the actions to either Close or Resolve the case

  Scenario: Data Reset Util 02 - Close or Resolve the first open case
    Given we find and open the first in flight case we come across for "Hazelwick School"
    Then we complete the actions to either Close or Resolve the case

  @close-case-proc-ops
  Scenario: Data Reset Util 03 - Close or Resolve all in flight cases for specific location
    Given we find and search for any cases for "Hazelwick School"
    Then we complete the actions to either Close or Resolve any open cases