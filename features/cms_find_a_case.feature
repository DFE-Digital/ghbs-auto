@cms @regression
Feature: GHBS - CMS - Find a case
  Background:
    Given we open and login to the proc ops CMS screens as an admin in the dev environment

  Scenario Outline: ES-1121 - CMS - Find a case
    Given we navigate to the Find a case screen
    And we search for our target term of "<SearchTerm>"
    Then we will see the correct "<SearchType>" in the returned results
    Examples:
      | SearchTerm            | SearchType          |
      # Finchley Catholic High School
      | 000880                | case id             |
      | test_user_1           | contact email       |
      | Hazelwick School      | organisation name   |
      | ABBEY ACADEMIES TRUST | establishment group |
      # Bourne Abbey Church of England Primary Academy
      | 136354                | URN                 |
      # Hazelwick School - Case 001593
      | 846175353591          | MPRN                |
      # Hazelwick School - Case 001607
      | 7084082061701         | MPAN                |
      # Case owner: Auto 1 Test User 1
      | test_user_2           | case owner          |