# frozen_string_literal: true

require "pages/fabs/fabs_home_page_methods"
require "pages/fabs/fabs_nav_methods"
require "pages/fabs/fabs_search_page_methods"
require "pages/shared_global_methods"
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
require "pages/energy/site_access/energy_site_access_methods"
require "pages/energy/vat/energy_which_vat_rate_methods"
require "pages/energy/billing/energy_billing_pref_methods"
require "pages/energy/billing/energy_billing_address_methods"
require "pages/cms/cms_signin_flow_methods"
require "pages/cms/cms_find_a_case_methods"
require "pages/cms/cms_top_nav_methods"
require "pages/cms/cms_case_actions_methods"

module Pages
  ##### FABS PAGES #####
  def home_page_methods
    @home_page_methods ||= FabsHomePageMethods.new
  end

  def nav_methods
    @nav_methods ||= FabsNavMethods.new
  end

  def search_methods
    @search_methods ||= FabsSearchMethods.new
  end

  ##### ENERGY PAGES: Pre Login #####
  def energy_start_page_methods
    @energy_start_page_methods ||= EnergyStartPageMethods.new(self)
  end

  def energy_signin_flow_methods
    @energy_signin_flow_methods ||= EnergySignInFlowMethods.new(self)
  end

  ##### ENERGY PAGES: Journey Start #####
  def energy_school_selection_methods
    @energy_school_selection_methods ||= EnergySchoolSelectionMethods.new(self)
  end

  def energy_are_you_authorised_page_methods
    @energy_are_you_authorised_page_methods ||= EnergyAreYouAuthorisedPageMethods.new(self)
  end

  def energy_switching_selection_methods
    @energy_switching_selection_methods ||= EnergySwitchingSelectionMethods.new(self)
  end

  ##### ENERGY PAGES: Gas #####
  def energy_gas_contract_methods
    @energy_gas_contract_methods ||= EnergyGasContractMethods.new(self)
  end

  def energy_gas_single_or_multi_methods
    @energy_gas_single_or_multi_methods ||= EnergyGasSingleOrMultiMethods.new(self)
  end

  def energy_gas_meter_details_methods
    @energy_gas_meter_details_methods ||= EnergyGasMeterDetailsMethods.new(self)
  end

  def energy_gas_mprn_summary_methods
    @energy_gas_mprn_summary_methods ||= EnergyGasMprnSummaryMethods.new(self)
  end

  def energy_gas_mprn_consolidated_methods
    @energy_gas_mprn_consolidated_methods ||= EnergyGasMprnConsolidatedMethods.new(self)
  end

  ##### ENERGY PAGES: Site Access #####
  def energy_site_access_methods
    @energy_site_access_methods ||= EnergySiteAccessMethods.new(self)
  end

  ##### ENERGY PAGES: VAT #####
  def energy_which_vat_rate_methods
    @energy_which_vat_rate_methods ||= EnergyWhichVatRateMethods.new(self)
  end

  ##### ENERGY PAGES: Billing #####
  def energy_billing_pref_methods
    @energy_billing_pref_methods ||= EnergyBillingPrefMethods.new(self)
  end

  def energy_billing_address_methods
    @energy_billing_address_methods ||= EnergyBillingAddressMethods.new(self)
  end

  ##### ENERGY PAGES: Task List #####
  ##### ENERGY PAGES: Completion #####

  ##### CMS PAGES #####
  def cms_signin_flow_methods
    @cms_signin_flow_methods ||= CmsSignInFlowMethods.new
  end

  def cms_top_nav_methods
    @cms_top_nav_methods ||= CmsTopNavMethods.new
  end

  def cms_find_a_case_methods
    @cms_find_a_case_methods ||= CmsFindACaseMethods.new
  end

  def cms_case_actions_methods
    @cms_case_actions_methods ||= CmsCaseActionsMethods.new
  end

  ##### SHARED PAGES #####
  def shared_global_methods
    @shared_global_methods ||= SharedGlobalMethods.new
  end
end

World(Pages)
