# frozen_string_literal: true

require "pages/fabs/fabs_home_page_methods"
require "pages/fabs/fabs_nav_methods"
require "pages/fabs/fabs_search_page_methods"
require "pages/shared_global_methods"
require "pages/energy/energy_start_page_methods"
require "pages/energy/energy_signin_flow_methods"
require "pages/energy/energy_school_selection_methods"
require "pages/energy/energy_are_you_authorised_page_methods"
require "pages/cms/cms_signin_flow_methods"
require "pages/cms/cms_find_a_case_methods"
require "pages/cms/cms_top_nav_methods"

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

  ##### ENERGY PAGES #####
  def energy_start_page_methods
    @energy_start_page_methods ||= EnergyStartPageMethods.new
  end

  def energy_signin_flow_methods
    @energy_signin_flow_methods ||= EnergySignInFlowMethods.new
  end

  def energy_school_selection_methods
    @energy_school_selection_methods ||= EnergySchoolSelectionPageMethods.new
  end

  def energy_are_you_authorised_page_methods
    @energy_are_you_authorised_page_methods ||= EnergyAreYouAuthorisedPageMethods.new
  end

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

  ##### SHARED PAGES #####
  def shared_global_methods
    @shared_global_methods ||= SharedGlobalMethods.new
  end
end

World(Pages)
