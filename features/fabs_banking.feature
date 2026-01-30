@regression @fabs
Feature: GHBS - FABS page behaviour
  Background:
    Given we open and validate the fabs homepage

  @wip
  Scenario: ES-1126 - Banking Page and http link validation
    Given we open the Savings options for schools buying option via the Banking and finance category
    When we open and validate the links out of the saving options page
    And we open and validate the links out of the Insignis savings platform page
    Then finally we validate the links on the Current accounts for schools page



