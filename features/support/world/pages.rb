# frozen_string_literal: true

require "pages/fabs_home_page_methods"
require "pages/fabs_nav_methods"
require "pages/fabs_search_page_methods"
require "pages/shared_global_methods"

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

  ##### SHARED PAGES #####
  def shared_global_methods
    @shared_global_methods ||= SharedGlobalMethods.new
  end
end

World(Pages)
