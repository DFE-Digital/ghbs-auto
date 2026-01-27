# frozen_string_literal: true

require "pages/cms/cms_base_page"
require "helpers/validation_helpers"
require "helpers/interaction_helpers"
require "components/cms/cms_top_nav_comps"
require "components/cms/frameworks/cms_frameworks_register_comps"
require "components/cms/frameworks/cms_frameworks_individual_framework_comps"

class CmsFrameworksMethods < CmsBasePage
  include ValidationHelpers
  include InteractionHelpers
  def validate_the_contentful_framework_has_been_updated
    # Navigate to the Frameworks Register screen
    cms_top_nav_comps.link_frameworks.click
    expect(page).to have_current_path(%r{/frameworks#frameworks-register}, url: true, wait: 10)
    expect(cms_frameworks_register_comps.text_page_heading.text).to include("Frameworks Register")

    # Find and select our framework from the list / narrow down the options
    cms_frameworks_register_comps.input_search.set(framework_state.title)
    cms_frameworks_register_comps.input_search.send_keys(:enter)
    sleep(1)

    # Confirm the status us "DfE approved"
    cms_frameworks_register_comps.checkbox_status_dfe_approved.click

    # Store the Framework Ref:
    framework_state.internal_framework_ref = cms_frameworks_register_comps.link_internal_framework_ref(framework_state.title).text

    # Open the framework
    cms_frameworks_register_comps.link_internal_framework_ref(framework_state.title).click
    expect(page).to have_current_path(%r{/frameworks/frameworks/}, url: true, wait: 10)
    expect(cms_frameworks_individual_framework_comps.text_page_heading.text).to include(framework_state.title)

    #  Validate the pain page data
    expect(cms_frameworks_individual_framework_comps.text_framework_status.text).to include("DfE approved")
    expect(cms_frameworks_individual_framework_comps.text_internal_framework_ref.text).to include(framework_state.internal_framework_ref)

    # Validate the updated date from the framework updated list is correct
    # Example: 09 January 2026 at 17:14:02
    ui_text = cms_frameworks_individual_framework_comps.text_latest_updated_activity_time.text
    ui_date = Date.strptime(ui_text.split(" at ").first, "%d %B %Y")
    expect(ui_date).to eq(Date.today)

    # Expand the list and validate the data from the "Framework Updated" list.
    cms_frameworks_individual_framework_comps.link_latest_updated_activity_see_details.click
    expect(cms_frameworks_individual_framework_comps.text_framework_updated_name.text).to include(framework_state.title)
    expect(cms_frameworks_individual_framework_comps.text_framework_updated_description.text).to include(framework_state.description)
    expect(cms_frameworks_individual_framework_comps.text_framework_updated_provider_reference.text).to include(framework_state.provider_ref)

    # Validate the data from the Framework Created list.
    exists = element_exists_across_pages?(
      target: -> { cms_frameworks_individual_framework_comps.link_framework_created_see_details_optional },
      next_button: -> { cms_frameworks_individual_framework_comps.link_pagination_next },
      marker: -> { cms_frameworks_individual_framework_comps.link_pagination_results },
      marker_change_timeout: 2 # “hot second” window, bounded
    )
    expect(exists).to be(true)

    cms_frameworks_individual_framework_comps.link_framework_created_see_details.click
    expect(cms_frameworks_individual_framework_comps.text_framework_created_source.text).to include("faf_import")
    expect(cms_frameworks_individual_framework_comps.text_framework_created_contentful_id.text).to include(framework_state.contentful_id)
  end

  def nav_to_frameworks_and_open_first_dfe_approved
    # Navigate to the Frameworks Register screen
    cms_top_nav_comps.link_frameworks.click
    expect(page).to have_current_path(%r{/frameworks#frameworks-register}, url: true, wait: 10)
    expect(cms_frameworks_register_comps.text_page_heading.text).to include("Frameworks Register")

    # Our Framework should include the name "Auto Test Solution"
    framework_partial_name = "Auto Test Solution"

    # Find and select our Auto Test Solution framework from the list / narrow down the options
    cms_frameworks_register_comps.input_search.set(framework_partial_name)
    cms_frameworks_register_comps.input_search.send_keys(:enter)
    sleep(1)

    # Confirm the status us "DfE approved"
    cms_frameworks_register_comps.checkbox_status_dfe_approved.click

    # Open the framework
    cms_frameworks_register_comps.link_internal_framework_ref_partial_name(framework_partial_name).click
    expect(page).to have_current_path(%r{/frameworks/frameworks/}, url: true, wait: 10)
    expect(cms_frameworks_individual_framework_comps.text_page_heading.text).to include(framework_partial_name)

    #  Validate the pain page data
    expect(cms_frameworks_individual_framework_comps.text_framework_status.text).to include("DfE approved")
  end
end
