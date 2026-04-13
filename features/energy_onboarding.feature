@energy @regression
Feature: GHBS - Energy - Onboarding Flow
  Background:
    Given we open and validate the start of the energy onboarding flow

@smoke
Scenario Outline: ES-890 - Energy Onboarding Flow - Gas + Direct Debit Only
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
  | MAT        | Hazelwick School | gas only  | 20      | Direct debit  |


Scenario Outline: ES-981: Energy Onboarding Flow - Electricity + Direct Debit Only
  Given we are logged in to the Energy Onboarding Flow as a <SchoolUser> School user
  And we select <SchoolName> from the bullet list and start the onboarding journey
  When the <Switching> option is selected and completed
  And the Site Contact screen is completed
  And the VAT flow is completed with a <VatFlow> percent option selected
  And the Billing section is completed with the <BillingOption> option selected
  And the CYA screen info is validated
  Then we complete the form and confirm our newly created case number
  Examples:
    | SchoolUser | SchoolName       | Switching     | VatFlow | BillingOption |
    | MAT        | Hazelwick School | electric only | 20      | Direct debit  |


  Scenario Outline: ES-986: Energy Onboarding Flow - Electricity and Gas + Direct Debit Only
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
      | MAT        | Hazelwick School | both      | 20      | Direct debit  |


  Scenario Outline: ES-1109 - Energy Onboarding Flow - VAT 5% + BACS
    Given we are logged in to the Energy Onboarding Flow as a <SchoolUser> School user
    And we select <SchoolName> from the bullet list and start the onboarding journey
    When the <Switching> option is selected and completed
    And the Site Contact screen is completed
    And the VAT flow is completed with a <VatFlow> percent option selected
    And the Billing section is completed with the <BillingOption> option selected
    And the CYA screen info is validated
    Then we complete the form and confirm our newly created case number
    Examples:
      | SchoolUser | SchoolName       | Switching     | VatFlow | BillingOption |
      | MAT        | Hazelwick School | gas only      | 5       | BACS          |
      | MAT        | Hazelwick School | electric only | 5       | BACS          |

  @wip
  Scenario Outline: ES-1220 - Energy Onboarding Flow - Email and Attachment validation
    Given we confirm the state of all flags within dev flipper
    And we complete the login and school selection process with user <SchoolUser> and school <SchoolName>
    When we complete an energy onboarding flow for both energy options
    And we navigate to the cms system to find our energy case
    Then we validate the expected emails and attachments are present
    And we validate the expected files have been generated
    Examples:
      | SchoolUser | SchoolName       |
      | MAT        | Hazelwick School |