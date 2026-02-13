# frozen_string_literal: true

require "pages/shared/shared_global_methods"
require "pages/cms/cms_base_page"
require "components/cms/cms_top_nav_comps"
require "components/cms/find_a_case/cms_find_a_case_page_comps"
require "helpers/validation_helpers"
class CmsRbaFindACaseMethods < CmsBasePage
  include ValidationHelpers

  def validate_find_a_case_page(
    top_nav_find_a_case_tab: false
  )
    expect(element_present?(cms_top_nav_comps.xpath_link_find_a_case)).to be(top_nav_find_a_case_tab)
    if top_nav_find_a_case_tab
      # Open Find a case screen
      cms_top_nav_comps.link_find_a_case.click
      expect(page).to have_current_path(%r{/support/cases/find-a-case/new}, url: true, wait: 20)
      wait_for_element_to_include(cms_find_a_case_page_comps.text_page_heading, "Find a case", timeout: 5)
    end
  end
end
