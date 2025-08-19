# frozen_string_literal: true

require_relative "../../../pages/fabs_home_page_methods"
require_relative "../../../pages/fabs_nav_methods"
require_relative "../../../pages/fabs_search_page_methods"

module Pages
  def home_page_methods
    @home_page_methods ||= FabsHomePageMethods.new
  end

  def nav_methods
    @nav_methods ||= FabsNavMethods.new
  end

  def search_methods
    @search_methods ||= FabsSearchMethods.new
  end
end

World(Pages)
