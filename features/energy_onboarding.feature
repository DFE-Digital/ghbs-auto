@energy
Feature: GHBS - Energy - Onboarding Flow
  Background:
    Given we open and validate the start of the energy onboarding flow

@smoke
Scenario Outline: Energy Onboarding Flow - Gas + Direct Debit Only
  Given we are logged in to the Energy Onboarding Flow as a "<SchoolUser>" School user
  When the "<switching>" option is selected and completed
  And the Site Contact screen is completed
  And the VAT flow is completed with a “<VatFlow>” percent option selected
  And the Billing section is completed with the “<BillingOption>” option selected
  And the CYA screen info is validated
  Then we complete the form and confirm our newly created case number

Examples:
| SchoolUser | switching | VatFlow | BillingOption |
| MAT        | gas only  | 20      | Direct Debit  |