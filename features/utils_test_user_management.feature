Feature: GHBS - Util - Data management
  Background:
    Given we open and login to the test signin orgs management area

  @add_users_to_test_orgs
  Scenario Outline: Test User Management Util 01 - Add users to all orgs
    Given we select org <Org> to add a user too
    When we add first name "XXX" last name "XXX" email "XXXX@education.gov.uk" to associate with the org
    And we set their permission level to "Approver"
    Then we see the confirmation message showing the user has been added to the org
    Examples:
      | Org                                      |
      # ABBEY ACADEMIES TRUST (Open)
      | UID: 2044, UKPRN: 10058308, UPIN: 135399 |
      # ABBEY MULTI ACADEMY TRUST (Open)
      | UID: 2046, UKPRN: 10059141, UPIN: 135666 |
      # ALCESTER GRAMMAR SCHOOL (Open)
      | UID: 2092, UKPRN: 10058464, UPIN: 135740 |
      # Bede Academy (Open)
      | URN: 135619, UKPRN: 10027529, UPIN: 118883 |
      # Beulah Junior School (Open)
      | URN: 101712, UKPRN: 10075055 |
      # Bourne Abbey Church of England Primary Academy (Open)
      | URN: 136354, UKPRN: 10032221, UPIN: 119379 |
      # Brookland Infant and Nursery School (Open)
      | URN: 101263, UKPRN: 10071950 |
      # Colsterworth Church of England Primary School (Open)
      | URN: 146279, UKPRN: 10080980, UPIN: 141133 |
      # E-ACT (Open)
      | UID: 2974, UKPRN: 10058234, UPIN: 135155 |
      # E-ACT Heartlands Academy (Open)
      | URN: 135907, UKPRN: 10028140, UPIN: 119140 |
      # Goldington Green Academy (Open)
      | URN: 139523, UKPRN: 10040822, UPIN: 123268 |
      # GOLDINGTON GREEN ACADEMY (Open)
      | UID: 3198, UKPRN: 10060358, UPIN: 137652 |
      # HAZELWICK SCHOOL (Open)
      | UID: 3361, UKPRN: 10058957, UPIN: 135335 |
      # Hazelwick School (Open)
      | URN: 137263, UKPRN: 10034642, UPIN: 120263 |
      # Heath Lane Nursery School (Open)
      | URN: 117070 |
      # Manor Park Primary School (Open)
      | URN: 103691, UKPRN: 10068848 |
      # Muriel Green Nursery School (Open)
      | URN: 133975 |
      # New River College Secondary (Open)
      | URN: 100391, UKPRN: 10016941, UPIN: 126941 |
      # Oakridge Junior School (Open)
      | URN: 115974, UKPRN: 10070608 |
      # Park Spring Primary School (Open)
      | URN: 107964, UKPRN: 10072251 |
      # PETERBOROUGH DIOCESE EDUCATION TRUST (Open)
      | UID: 4192, UKPRN: 10060427, UPIN: 137857 |
      # THE AYLESBURY VALE ACADEMY (Open)
      | UID: 2218, UKPRN: 10058250, UPIN: 135211 |


  Scenario Outline: Test User Management Util 02 - Add users to cut down list all orgs
    Given we select org <Org> to add a user too
    When we add first name "XXX" last name "XXXX" email "XXXX@education.gov.uk" to associate with the org
    And we set their permission level to "End User"
    Then we see the confirmation message showing the user has been added to the org
    Examples:
      | Org                                      |
      # MAT - ABBEY ACADEMIES TRUST (Open)
      | UID: 2044, UKPRN: 10058308, UPIN: 135399 |
      # SAT - ALCESTER GRAMMAR SCHOOL (Open)
      | UID: 2092, UKPRN: 10058464, UPIN: 135740 |
      # Single School - Colsterworth Church of England Primary School (Open)
      | URN: 146279, UKPRN: 10080980, UPIN: 141133 |
      # Single School - Heath Lane Nursery School (Open)
      | URN: 117070 |
      # Single School - Manor Park Primary School (Open)
      | URN: 103691, UKPRN: 10068848 |
      # Single School - Muriel Green Nursery School (Open)
      | URN: 133975 |
      # MAT - PETERBOROUGH DIOCESE EDUCATION TRUST (Open)
      | UID: 4192, UKPRN: 10060427, UPIN: 137857 |
      # SAT - THE AYLESBURY VALE ACADEMY (Open)
      | UID: 2218, UKPRN: 10058250, UPIN: 135211 |
