# frozen_string_literal: true

require "pages/shared_global_methods"
require "pages/cms/cms_base_page"
require "components/cms/cms_login_page_comps"

class CmsSignInFlowMethods < CmsBasePage

  def open_cms_cec_homepage
    visit SECRETS["dev_cec_cms_homepage_url"]
  end

  def validate_homepage_loaded
    expect(page).to have_current_path(%r{/sign-in#my-cases}, url: true, wait: 10)
    expect(cms_login_page_comps.text_page_heading.text).to include("Case management system")
  end

end
