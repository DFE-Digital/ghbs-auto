# frozen_string_literal: true

require "components/cms/cms_login_page_comps"
require "components/cms/cms_mycases_page_comps"
require "components/cms/cms_top_nav_comps"

module SharedCmsComps
  # Pre Flow pages
  def cms_login_page_comps = @cms_login_page_comps ||= CmsLoginPageComps.new

  # My Cases
  def cms_mycases_page_comps = @cms_mycases_page_comps ||= CmsMyCasesPageComps.new

  # Navigation
  def cms_top_nav_comps = @cms_top_nav_comps ||= CmsTopNavComps.new

end
