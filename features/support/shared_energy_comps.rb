# frozen_string_literal: true

require "components/energy/pre_login/energy_start_comps"
require "components/energy/pre_login/energy_before_you_start_comps"
require "components/energy/journey_start/energy_which_school_buying_for_comps"
require "components/energy/journey_start/energy_are_you_authorised_comps"
require "components/energy/journey_start/energy_what_are_you_switching_comps"
require "components/energy/gas/energy_gas_bill_consolidated_comps"
require "components/energy/gas/energy_gas_contract_comps"
require "components/energy/gas/energy_gas_meter_detail_comps"
require "components/energy/gas/energy_gas_mprn_summary_comps"
require "components/energy/gas/energy_gas_remove_mprn_comps"
require "components/energy/gas/energy_gas_single_or_multi_meter_comps"
require "components/energy/electric/energy_electric_bill_consolidated_comps"
require "components/energy/electric/energy_electric_contract_comps"
require "components/energy/electric/energy_electric_meter_detail_comps"
require "components/energy/electric/energy_electric_mpan_summary_comps"
require "components/energy/electric/energy_electric_remove_mpan_comps"
require "components/energy/electric/energy_electric_single_or_multi_meter_comps"
require "components/energy/site_access/energy_site_access_comps"
require "components/energy/vat/energy_are_these_correct_vat_details_comps"
require "components/energy/vat/energy_vat_certificate_comps"
require "components/energy/vat/energy_vat_contact_info_comps"
require "components/energy/vat/energy_which_vat_rate_comps"
require "components/energy/billing/energy_billing_address_comps"
require "components/energy/billing/energy_billing_pref_comps"
require "components/energy/task_list/energy_task_list_comps"
require "components/energy/completion/energy_check_your_answers_comps"
require "components/energy/completion/energy_info_submitted_comps"
require "components/energy/completion/energy_loa_comps"

module SharedEnergyComps
  # Pre Flow pages
  def energy_start_comps = @energy_start_comps ||= EnergyStartComps.new
  def energy_before_you_start_comps = @energy_before_you_start_comps ||= EnergyBeforeYouStartComps.new

  # School selection and validation pages
  def energy_which_school_buying_for_comps = @energy_which_school_buying_for_comps ||= EnergyWhichSchoolBuyingForComps.new
  def energy_are_you_authorised_comps = @energy_are_you_authorised_comps ||= EnergyAreYouAuthorisedComps.new
  def energy_what_are_you_switching_comps = @energy_what_are_you_switching_comps ||= EnergyWhatAreYouSwitchingComps.new

  # Gas specific pages
  def energy_gas_bill_consolidated_comps = @energy_gas_bill_consolidated_comps ||= EnergyGasBillConsolidatedComps.new
  def energy_gas_contract_comps = @energy_gas_contract_comps ||= EnergyGasContractComps.new
  def energy_gas_meter_detail_comps = @energy_gas_meter_detail_comps ||= EnergyGasMeterDetailComps.new
  def energy_gas_mprn_summary_comps = @energy_gas_mprn_summary_comps ||= EnergyGasMPRNSummaryComps.new
  def energy_gas_remove_mprn_comps = @energy_gas_remove_mprn_comps ||= EnergyGasRemoveMprnComps.new
  def energy_gas_single_or_multi_meter_comps = @energy_gas_single_or_multi_meter_comps ||= EnergyGasSingleOrMultiMeterComps.new

  # Electric specific pages
  def energy_electric_bill_consolidated_comps = @energy_electric_bill_consolidated_comps ||= EnergyElectricBillConsolidatedComps.new
  def energy_electric_contract_comps = @energy_electric_contract_comps ||= EnergyElectricContractComps.new
  def energy_electric_meter_detail_comps = @energy_electric_meter_detail_comps ||= EnergyElectricMeterDetailComps.new
  def energy_electric_mpan_summary_comps = @energy_electric_mpan_summary_comps ||= EnergyElectricMpanSummaryComps.new
  def energy_electric_remove_mpan_comps = @energy_electric_remove_mpan_comps ||= EnergyElectricRemoveMpanComps.new
  def energy_electric_single_or_multi_meter_comps = @energy_electric_single_or_multi_meter_comps ||= EnergyElectricSingleOrMultiMeterComps.new

  # Site Access
  def energy_site_access_comps = @energy_site_access_comps ||= EnergySiteAccessComps.new

  # VAT
  def energy_are_these_correct_vat_details_comps = @energy_are_these_correct_vat_details_comps ||= EnergyAreTheseCorrectVatDetailsComps.new
  def energy_vat_certificate_comps = @energy_vat_certificate_comps ||= EnergyVatCertificateComps.new
  def energy_vat_contact_info_comps = @energy_vat_contact_info_comps ||= EnergyVatContactInfoComps.new
  def energy_which_vat_rate_comps = @energy_which_vat_rate_comps ||= EnergyWhichVatRateComps.new

  # Billing
  def energy_billing_address_comps = @energy_billing_address_comps ||= EnergyBillingAddressComps.new
  def energy_billing_pref_comps = @energy_billing_pref_comps ||= EnergyBillingPrefComps.new

  # Task List
  def energy_task_list_comps = @energy_task_list_comps ||= EnergyTaskListComps.new

  # Completion
  def energy_check_your_answers_comps = @energy_check_your_answers_comps ||= EnergyCheckYourAnswersComps.new
  def energy_info_submitted_comps = @energy_info_submitted_comps ||= EnergyInfoSubmittedComps.new
  def energy_loa_comps = @energy_loa_comps ||= EnergyLoaComps.new
end
