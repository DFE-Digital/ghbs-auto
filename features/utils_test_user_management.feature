Feature: GHBS - Util - Data management
  Background:
    Given we open and login to the test signin orgs management area

  @add_users_to_test_orgs_1
  Scenario Outline: Test User Management Util 01 - Add users to all orgs
    Given we select org <Org> to add a user too
    When we add first name "Paul" last name "Custance" email "Paul.CUSTANCE@education.gov.uk" to associate with the org
    And we set their permission level to "End User"
    Then we see the confirmation message showing the user has been added to the org
    Examples:
      | Org                                      |
      # ABBEY ACADEMIES TRUST (Open) Multi-academy trust
      | UID: 2044, UKPRN: 10058308, UPIN: 135399 |
      # ABBEY MULTI ACADEMY TRUST (Open) Multi-academy trust
      | UID: 2046, UKPRN: 10059141, UPIN: 135666 |
      # ALCESTER GRAMMAR SCHOOL (Open) Single-academy trust
      | UID: 2092, UKPRN: 10058464, UPIN: 135740 |
      # Bede Academy (Open) Academy sponsor led - Part of EMMANUEL SCHOOLS FOUNDATION
      | URN: 135619, UKPRN: 10027529, UPIN: 118883 |
      # Beulah Junior School (Open) Community school
      | URN: 101712, UKPRN: 10075055 |
      # Bourne Abbey Church of England Primary Academy (Open) Academy converter - Part of ABBEY ACADEMIES TRUST
      | URN: 136354, UKPRN: 10032221, UPIN: 119379 |
      # Brookland Infant and Nursery School (Open) Community school
      | URN: 101263, UKPRN: 10071950 |
      # Colsterworth Church of England Primary School (Open) Academy sponsor led  - Part of ABBEY ACADEMIES TRUST
      | URN: 146279, UKPRN: 10080980, UPIN: 141133 |
      # E-ACT (Open) Multi-academy trust
      | UID: 2974, UKPRN: 10058234, UPIN: 135155 |
      # E-ACT Heartlands Academy (Open) Academy sponsor led - Part of E-ACT
      | URN: 135907, UKPRN: 10028140, UPIN: 119140 |
      # Goldington Green Academy (Open) Academy converter - Part of HEART ACADEMIES TRUST
      | URN: 139523, UKPRN: 10040822, UPIN: 123268 |
      # GOLDINGTON GREEN ACADEMY (Open) Single-academy trust
      | UID: 3198, UKPRN: 10060358, UPIN: 137652 |
      # HAZELWICK SCHOOL (Open) Single-academy trust
      | UID: 3361, UKPRN: 10058957, UPIN: 135335 |
      # Hazelwick School (Open) Single-academy trust - Part of HAZELWICK SCHOOL
      | URN: 137263, UKPRN: 10034642, UPIN: 120263 |
      # Heath Lane Nursery School (Open) Local authority nursery school - Part of Roots Federation
      | URN: 117070 |
      # Manor Park Primary School (Open) Community school
      | URN: 103691, UKPRN: 10068848 |
      # Muriel Green Nursery School (Open) Local authority nursery school
      | URN: 133975 |
      # Oakridge Junior School (Open) Community school - Part of Oakridge Schools Federation
      | URN: 115974, UKPRN: 10070608 |
      # Park Spring Primary School (Open) Community school
      | URN: 107964, UKPRN: 10072251 |
      # PETERBOROUGH DIOCESE EDUCATION TRUST (Open) Multi-academy trust
      | UID: 4192, UKPRN: 10060427, UPIN: 137857 |
      # THE AYLESBURY VALE ACADEMY (Open) Single-academy trust
      | UID: 2218, UKPRN: 10058250, UPIN: 135211 |

  @add_users_to_test_orgs_2
  Scenario Outline: Test User Management Util 02 - Add users to cut down list all orgs
    Given we select org <Org> to add a user too
    When we add first name "XXX" last name "XXXX" email "XXXX@education.gov.uk" to associate with the org
    And we set their permission level to "End User"
    Then we see the confirmation message showing the user has been added to the org
    Examples:
      | Org                                      |
      # MAT - ABBEY ACADEMIES TRUST (Open)  Multi-academy trust
      | UID: 2044, UKPRN: 10058308, UPIN: 135399 |
      # SAT - ALCESTER GRAMMAR SCHOOL (Open)  Single-academy trust
      | UID: 2092, UKPRN: 10058464, UPIN: 135740 |
      # Single School - Colsterworth Church of England Primary School (Open)  Academy sponsor led  - Part of ABBEY ACADEMIES TRUST
      | URN: 146279, UKPRN: 10080980, UPIN: 141133 |
      # Single School - Heath Lane Nursery School (Open) Local authority nursery school - Part of Roots Federation
      | URN: 117070 |
      # Single School - Manor Park Primary School (Open) Community school
      | URN: 103691, UKPRN: 10068848 |
      # Single School - Muriel Green Nursery School (Open) Local authority nursery school
      | URN: 133975 |
      # MAT - PETERBOROUGH DIOCESE EDUCATION TRUST (Open)  Multi-academy trust
      | UID: 4192, UKPRN: 10060427, UPIN: 137857 |
      # SAT - THE AYLESBURY VALE ACADEMY (Open)  Single-academy trust
      | UID: 2218, UKPRN: 10058250, UPIN: 135211 |