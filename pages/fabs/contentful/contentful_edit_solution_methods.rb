# frozen_string_literal: true

require "pages/fabs/fabs_base_page"
require "helpers/url_nav_helpers"
require "helpers/validation_helpers"
require "components/fabs/contentful/contentful_cms_search_comps"
require "components/fabs/contentful/contentful_cms_solution_comps"

class ContentfulEditSolutionMethods < FabsBasePage
  include UrlHelpers
  include ValidationHelpers

  def open_auto_solution_page_and_edit_content(framework_name)
    # Search for 'Auto Test Solution - Please Ignore'
    wait_for_heading_includes(contentful_cms_search_comps.text_page_heading, "All content", timeout: 5)
    contentful_cms_search_comps.input_search_field.set(framework_name)
    wait_for_heading_includes(contentful_cms_search_comps.link_select_returned_result(framework_name), framework_name, timeout: 5)
    contentful_cms_search_comps.link_select_returned_result(framework_name).click

    # Open Solution
    expect(page).to have_current_path(%r{/entries/}, url: true, wait: 10)
    wait_for_heading_includes(contentful_cms_solution_comps.text_page_heading, "Auto Test Solution - Please Ignore", timeout: 5)

    # Update title
    contentful_cms_solution_comps.input_title.set("Auto Test Solution - Please Ignore #{Time.now.strftime('%m-%d-%Y-%H-%M-%S')}")

    # Update Description
    contentful_cms_solution_comps.input_description.set("This is a test solution used to prove out the sync job logic and ensure its correctly updating existing frameworks within the register. #{Time.now.strftime('%S-%M-%H-%m-%d-%Y-%H-%M-%S')}")

    # Update Provider Reference
    contentful_cms_solution_comps.input_provider_reference.set("Auto Test Solution - Provider Ref - #{Time.now.strftime('%m-%d-%Y-%H-%M-%S')}")

    # Submit Change
    contentful_cms_solution_comps.button_publish_changes.click
    wait_for_heading_includes(contentful_cms_solution_comps.text_current_status, "published", timeout: 5)
  end
end
