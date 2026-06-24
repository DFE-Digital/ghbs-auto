@selenium-axe @energy
Feature: GHBS - Energy page accessibility checks
  Background:
    Given we open and validate the start of the energy onboarding flow
    And we enable the selenium axe checks on each page

  Scenario Outline: ES-1116: Energy Onboarding Flow - Accessibility - Electricity and Gas + Direct Debit Only
    Given we are logged in to the Energy Onboarding Flow as a <SchoolUser> School user
    And we select <SchoolName> from the bullet list and start the onboarding journey
    When the <Switching> option is selected and completed
    And the Site Contact screen is completed
    And the VAT flow is completed with a <VatFlow> percent option selected
    And the Billing section is completed with the <BillingOption> option selected
    And the CYA screen info is validated
    Then we complete the form and confirm our newly created case number
    Examples:
      | SchoolUser | SchoolName       | Switching | VatFlow | BillingOption |
      | MAT        | Hazelwick School | both      | 5       | Direct debit  |

  Scenario Outline: CORE-109: Energy Onboarding Flow - Accessibility - Rejecting MPRN and MPAN
    Given we are logged in to the Energy Onboarding Flow as a <SchoolUser> School user
    And we select <SchoolName> from the bullet list and start the onboarding journey
    When the <Switching> option is selected and completed
    And the Site Contact screen is completed
    And the VAT flow is completed with a <VatFlow> percent option selected
    And the Billing section is completed with the <BillingOption> option selected
    And the CYA screen info is validated
    Then we complete the form and confirm our newly created case number
    Examples:
      | SchoolUser | SchoolName       | Switching        | VatFlow | BillingOption |
      | MAT        | Hazelwick School | both_with_reject | 5       | Direct debit  |

  Scenario Outline: CORE-176 - Energy Onboarding Flow - Accessibility - Email and Attachment validation
    Given we confirm the state of all flags within dev flipper
    And we complete the login and school selection process with user <SchoolUser> and school <SchoolName>
    When we complete an energy onboarding flow for both energy options
    And we navigate to the cms system to find our energy case
    Then we validate the expected emails and attachments are present
    And we validate the expected files have been generated
    Examples:
      | SchoolUser | SchoolName       |
      | MAT        | Hazelwick School |