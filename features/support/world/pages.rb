# frozen_string_literal: true

require "pages/fabs/fabs_home_page_methods"
require "pages/fabs/fabs_nav_methods"
require "pages/fabs/fabs_search_page_methods"
require "pages/shared/shared_global_methods"
require "pages/energy/pre_login/energy_start_page_methods"
require "pages/energy/pre_login/energy_signin_flow_methods"
require "pages/energy/journey_start/energy_school_selection_methods"
require "pages/energy/journey_start/energy_are_you_authorised_page_methods"
require "pages/energy/journey_start/energy_switching_selection_methods"
require "pages/energy/gas/energy_gas_contract_methods"
require "pages/energy/gas/energy_gas_single_or_multi_methods"
require "pages/energy/gas/energy_gas_meter_details_methods"
require "pages/energy/gas/energy_gas_mprn_summary_methods"
require "pages/energy/gas/energy_gas_mprn_consolidated_methods"
require "pages/energy/electric/energy_electric_contract_methods"
require "pages/energy/electric/energy_electric_single_or_multi_methods"
require "pages/energy/electric/energy_electric_meter_details_methods"
require "pages/energy/site_access/energy_site_access_methods"
require "pages/energy/vat/energy_which_vat_rate_methods"
require "pages/energy/billing/energy_billing_pref_methods"
require "pages/energy/billing/energy_billing_address_methods"
require "pages/energy/completion/energy_check_your_answers_methods"
require "pages/energy/completion/energy_loa_methods"
require "pages/energy/completion/energy_info_submitted_methods"
require "pages/cms/cms_signin_flow_methods"
require "pages/cms/cms_find_a_case_methods"
require "pages/cms/cms_top_nav_methods"
require "pages/cms/case/cms_case_actions_methods"
require "pages/cms/case/cms_case_evaluation_flow_methods"
require "pages/cms/cms_create_a_new_case_methods"
require "pages/cms/case/cms_case_evaluation_school_user_flow_methods"
require "pages/user_management/test_user_management_util_methods"


module Pages
  def resolved_world
    respond_to?(:world) ? world : self
  end

  ##### FABS PAGES #####
  def home_page_methods
    @home_page_methods ||= FabsHomePageMethods.new(resolved_world)
  end

  def nav_methods
    @nav_methods ||= FabsNavMethods.new(resolved_world)
  end

  def search_methods
    @search_methods ||= FabsSearchMethods.new(resolved_world)
  end

  ##### ENERGY PAGES: Pre Login #####
  def energy_start_page_methods
    @energy_start_page_methods ||= EnergyStartPageMethods.new(resolved_world)
  end

  def energy_signin_flow_methods
    @energy_signin_flow_methods ||= EnergySignInFlowMethods.new(resolved_world)
  end

  ##### ENERGY PAGES: Journey Start #####
  def energy_school_selection_methods
    @energy_school_selection_methods ||= EnergySchoolSelectionMethods.new(resolved_world)
  end

  def energy_are_you_authorised_page_methods
    @energy_are_you_authorised_page_methods ||= EnergyAreYouAuthorisedPageMethods.new(resolved_world)
  end

  def energy_switching_selection_methods
    @energy_switching_selection_methods ||= EnergySwitchingSelectionMethods.new(resolved_world)
  end

  ##### ENERGY PAGES: Gas #####
  def energy_gas_contract_methods
    @energy_gas_contract_methods ||= EnergyGasContractMethods.new(resolved_world)
  end

  def energy_gas_single_or_multi_methods
    @energy_gas_single_or_multi_methods ||= EnergyGasSingleOrMultiMethods.new(resolved_world)
  end

  def energy_gas_meter_details_methods
    @energy_gas_meter_details_methods ||= EnergyGasMeterDetailsMethods.new(resolved_world)
  end

  def energy_gas_mprn_summary_methods
    @energy_gas_mprn_summary_methods ||= EnergyGasMprnSummaryMethods.new(resolved_world)
  end

  def energy_gas_mprn_consolidated_methods
    @energy_gas_mprn_consolidated_methods ||= EnergyGasMprnConsolidatedMethods.new(resolved_world)
  end

  ##### ENERGY PAGES: Electric #####
  def energy_electric_contract_methods
    @energy_electric_contract_methods ||= EnergyElectricContractMethods.new(resolved_world)
  end

  def energy_electric_single_or_multi_methods
    @energy_electric_single_or_multi_methods ||= EnergyElectricSingleOrMultiMethods.new(resolved_world)
  end

  def energy_electric_meter_details_methods
    @energy_electric_meter_details_methods ||= EnergyElectricMeterDetailsMethods.new(resolved_world)
  end

  ##### ENERGY PAGES: Site Access #####
  def energy_site_access_methods
    @energy_site_access_methods ||= EnergySiteAccessMethods.new(resolved_world)
  end

  ##### ENERGY PAGES: VAT #####
  def energy_which_vat_rate_methods
    @energy_which_vat_rate_methods ||= EnergyWhichVatRateMethods.new(resolved_world)
  end

  ##### ENERGY PAGES: Billing #####
  def energy_billing_pref_methods
    @energy_billing_pref_methods ||= EnergyBillingPrefMethods.new(resolved_world)
  end

  def energy_billing_address_methods
    @energy_billing_address_methods ||= EnergyBillingAddressMethods.new(resolved_world)
  end

  ##### ENERGY PAGES: Completion #####
  def energy_check_your_answers_methods
    @energy_check_your_answers_methods ||= EnergyCheckYourAnswersMethods.new(resolved_world)
  end

  def energy_loa_methods
    @energy_loa_methods ||= EnergyLoaMethods.new(resolved_world)
  end

  def energy_info_submitted_methods
    @energy_info_submitted_methods ||= EnergyInfoSubmittedMethods.new(resolved_world)
  end

  ##### CMS PAGES #####
  def cms_signin_flow_methods
    @cms_signin_flow_methods ||= CmsSignInFlowMethods.new(resolved_world)
  end

  def cms_top_nav_methods
    @cms_top_nav_methods ||= CmsTopNavMethods.new(resolved_world)
  end

  def cms_find_a_case_methods
    @cms_find_a_case_methods ||= CmsFindACaseMethods.new(resolved_world)
  end

  def cms_case_actions_methods
    @cms_case_actions_methods ||= CmsCaseActionsMethods.new(resolved_world)
  end

  def cms_create_a_new_case_methods
    @cms_create_a_new_case_methods ||= CmsCreateANewCaseMethods.new(resolved_world)
  end

  def cms_case_evaluation_flow_methods
    @cms_case_evaluation_flow_methods ||= CmsCaseEvaluationFlowMethods.new(resolved_world)
  end

  def cms_case_evaluation_school_user_flow_methods
    @cms_case_evaluation_school_user_flow_methods ||= CmsCaseEvaluationSchoolUserFlowMethods.new(resolved_world)
  end

  ##### SHARED PAGES #####
  def shared_global_methods
    @shared_global_methods ||= SharedGlobalMethods.new(resolved_world)
  end

  def test_user_management_util_methods
    @test_user_management_util_methods ||= TestUserManagementUtilMethods.new(resolved_world)
  end

end

World(Pages)
