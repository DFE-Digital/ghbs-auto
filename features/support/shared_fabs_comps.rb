# frozen_string_literal: true

require "components/fabs/fabs_404_comps"
require "components/fabs/fabs_500_comps"
require "components/fabs/fabs_top_nav_comps"
require "components/fabs/fabs_footer_nav_comps"
require "components/fabs/fabs_accessibility_statement_comps"
require "components/fabs/fabs_terms_and_conditions_comps"
require "components/fabs/fabs_home_comps"
require "components/fabs/fabs_buying_category_comps"
require "components/fabs/fabs_buying_option_comps"
require "components/fabs/fabs_search_comps"
require "components/fabs/fabs_all_buying_options_comps"
require "components/fabs/fabs_savings_options_for_schools_comps"
require "components/fabs/fabs_insignis_savings_platform_comps"
require "components/fabs/fabs_current_accounts_comps"
require "components/fabs/fabs_shared_related_content_comps"
require "components/fabs/contentful/contentful_cms_login_comps"
require "components/fabs/contentful/contentful_cms_login_landing_page_comps"
require "components/fabs/contentful/contentful_cms_search_comps"
require "components/fabs/contentful/contentful_cms_solution_comps"

module SharedFabsComps
  # Error Pages
  def fabs_404_comps = @fabs_404_comps ||= Fabs404Comps.new
  def fabs_500_comps = @fabs_500_comps ||= Fabs500Comps.new

  # Header / Footer
  def fabs_top_nav_comps = @fabs_top_nav_comps ||= FabsTopNavComps.new
  def fabs_footer_nav_comps = @fabs_footer_nav_comps ||= FabsFooterNavComps.new

  def fabs_accessibility_statement_comps
    @fabs_accessibility_statement_comps ||= FabsAccessibilityStatementComps.new
  end

  def fabs_terms_and_conditions_comps = @fabs_terms_and_conditions_comps ||= FabsTermsAndConditionsComps.new

  # Core Flow
  def fabs_home_comps = @fabs_home_comps ||= FabsHomeComps.new
  def fabs_buying_category_comps = @fabs_buying_category_comps ||= FabsBuyingCategoryComps.new
  def fabs_buying_option_comps = @fabs_buying_option_comps ||= FabsBuyingOptionComps.new

  # Search
  def fabs_search_comps = @fabs_search_comps ||= FabsSearchComps.new
  def fabs_all_buying_options_comps = @fabs_all_buying_options_comps ||= FabsAllBuyingOptionsComps.new

  # Banking
  def fabs_savings_options_for_schools_comps = @fabs_savings_options_for_schools_comps ||= FabsSavingsOptionsForSchoolsComps.new
  def fabs_insignis_savings_platform_comps = @fabs_insignis_savings_platform_comps ||= FabsInsignisSavingsPlatformComps.new
  def fabs_current_accounts_comps = @fabs_current_accounts_comps ||= FabsCurrentAccountsComps.new
  def fabs_shared_related_content_comps = @fabs_shared_related_content_comps ||= FabsSharedRelatedContentComps.new

  # Contentful
  def contentful_cms_login_comps = @contentful_cms_login_comps ||= ContentfulCmsLoginComps.new
  def contentful_cms_login_landing_page_comps = @contentful_cms_login_landing_page_comps ||= ContentfulCmsLoginLandingPageComps.new
  def contentful_cms_search_comps = @contentful_cms_search_comps ||= ContentfulCmsSearchComps.new
  def contentful_cms_solution_comps = @contentful_cms_solution_comps ||= ContentfulCmsSolutionComps.new
end
