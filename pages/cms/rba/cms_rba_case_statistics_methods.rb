# frozen_string_literal: true

require "pages/shared/shared_global_methods"
require "pages/cms/cms_base_page"
require "components/cms/cms_case_statistics_comps"
require "components/cms/cms_top_nav_comps"
require "helpers/validation_helpers"

class CmsRbaCaseStatisticsMethods < CmsBasePage
  include ValidationHelpers

  def section_case_statistics_tabs(
    main_case_statistics: false,
    overview_by_person_tab: false,
    overview_by_stage_tab: false,
    overview_by_category_tab: false
  )
    # Validate the top page link
    expect(element_present?(cms_top_nav_comps.xpath_link_case_statistics)).to be(main_case_statistics)

    if main_case_statistics
      # Nav to my case statistics screen
      cms_top_nav_comps.link_case_statistics.click
      expect(page).to have_current_path(%r{/support/case_statistics#stats-by-person}, url: true, wait: 20)
      wait_for_element_to_include(cms_case_statistics_comps.text_page_heading, "Case statistics", timeout: 5)

      # Validate the Case Statistics page tabs
      expect(element_present?(cms_case_statistics_comps.xpath_link_overview_by_person)).to be(overview_by_person_tab)
      expect(element_present?(cms_case_statistics_comps.xpath_link_overview_by_stage)).to be(overview_by_stage_tab)
      expect(element_present?(cms_case_statistics_comps.xpath_link_overview_by_category)).to be(overview_by_category_tab)
    end
  end
end
