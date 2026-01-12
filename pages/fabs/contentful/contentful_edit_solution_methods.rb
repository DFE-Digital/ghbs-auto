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
    wait_for_heading_includes(contentful_cms_solution_comps.text_page_heading, framework_name, timeout: 5)

    # Update and store title
    framework_state.title = framework_name + " #{Time.now.strftime('%m-%d-%Y-%H-%M-%S')}"
    contentful_cms_solution_comps.input_title.set(framework_state.title)

    # Update and store  Description
    framework_state.description = "This is a test solution used to prove out the sync job logic and ensure its correctly updating existing frameworks within the register. #{Time.now.strftime('%S-%M-%H-%m-%d-%Y-%H-%M-%S')}"
    contentful_cms_solution_comps.input_description.set(framework_state.description)

    # Update and store Dfe Buying Solution
    contentful_cms_solution_comps.link_dfe_buying_solution_clear.click
    contentful_cms_solution_comps.radio_dfe_buying_solution_no.click
    framework_state.dfe_buying_solution = "no"

    # Update and store  Provider Reference
    framework_state.provider_ref = "Auto Test Solution - Provider Ref - #{Time.now.strftime('%m-%d-%Y-%H-%M-%S')}"
    contentful_cms_solution_comps.input_provider_reference.set(framework_state.provider_ref)

    # We are instantly asserting the value of the field, as we have had issues with submitting the form before its realized data has been entered.
    expect(contentful_cms_solution_comps.input_provider_reference.value).to eq(framework_state.provider_ref)

    # Store remaining fields
    framework_state.expiry_date = contentful_cms_solution_comps.input_expiry.value
    # framework_state.summary = contentful_cms_solution_comps.input_summary.text
    framework_state.provider_name = contentful_cms_solution_comps.input_provider_name.value
    framework_state.url = contentful_cms_solution_comps.input_url.value
    framework_state.slug = contentful_cms_solution_comps.input_slug.value
    framework_state.cta = contentful_cms_solution_comps.input_call_to_action.value
    framework_state.provider_initials = contentful_cms_solution_comps.input_provider_initials.value

    sleep(0.5) # to give the ui time to render the entered text, as we have had issues with it not keeping up with the script.

    # Submit Change
    contentful_cms_solution_comps.button_publish_changes.click
    wait_for_heading_includes(contentful_cms_solution_comps.text_current_status, "published", timeout: 5)
  end
end
