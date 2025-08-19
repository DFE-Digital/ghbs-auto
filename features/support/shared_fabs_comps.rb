# frozen_string_literal: true

require_relative "../../components/fabs_404_page_comps"
require_relative "../../components/fabs_500_page_comps"
require_relative "../../components/fabs_top_nav_comps"
require_relative "../../components/fabs_footer_nav_comps"
require_relative "../../components/fabs_accessibility_statement_page_comps"
require_relative "../../components/fabs_terms_and_conditions_page_comps"
require_relative "../../components/fabs_home_page_comps"
require_relative "../../components/fabs_buying_category_page_comps"
require_relative "../../components/fabs_buying_option_page_comps"
require_relative "../../components/fabs_search_page_comps"
require_relative "../../components/fabs_all_buying_options_page_comps"

module SharedFabsComps
  # Error Pages
  def fabs_404_comps = @fabs_404_comps ||= Fabs404PageComps.new
  def fabs_500_comps = @fabs_500_comps ||= Fabs500PageComps.new

  # Header / Footer
  def fabs_top_nav_comps = @fabs_top_nav_comps ||= FabsTopNavComps.new
  def fabs_footer_comps = @fabs_footer_comps ||= FabsFooterNavComps.new

  def fabs_access_statement_comps
    @fabs_access_statement_comps ||= FabsAccessibilityStatementPageComps.new
  end

  def fabs_terms_and_conditions_comps = @fabs_terms_and_conditions_comps ||= FabsTermsAndConditionsPageComps.new

  # Core Flow
  def fabs_home_page_comps = @fabs_home_page_comps ||= FabsHomePageComps.new
  def fabs_buying_cat_comps = @fabs_buying_cat_comps ||= FabsBuyingCategoryPageComps.new
  def fabs_buying_option_comps = @fabs_buying_option_comps ||= FabsBuyingOptionPageComps.new

  # Search
  def fabs_search_comps = @fabs_search_comps ||= FabsSearchPageComps.new
  def fabs_all_buying_options_comps = @fabs_all_buying_options_comps ||= FabsAllBuyingOptionsPageComps.new
end
