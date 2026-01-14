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