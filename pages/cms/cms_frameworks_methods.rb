# frozen_string_literal: true

require "pages/cms/cms_base_page"
require "helpers/validation_helpers"
require "helpers/interaction_helpers"
require "components/cms/cms_top_nav_comps"
require "components/cms/frameworks/cms_frameworks_register_comps"
require "components/cms/frameworks/cms_frameworks_individual_framework_comps"
require "components/cms/frameworks/cms_frameworks_individual_fw_categories_comps"

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

  def reset_all_checkboxes
    fw_cats = cms_frameworks_individual_fw_categories_comps

    fw_cats.checkbox_label_pairs.each do |checkbox_method, label_method|
      checkbox = fw_cats.public_send(checkbox_method)
      fw_cats.public_send(label_method).click if checkbox.checked?
    end
  end

  def add_multiple_test_categories_to_current_framework
    # Our Framework should include the name "Auto Test Solution"
    framework_partial_name = "Auto Test Solution"

    # First we need to see if there are already categories on this framework.
    if cms_frameworks_individual_framework_comps.add_categories_visible?
      # Leave the statement and progress with the test as normal.
    elsif cms_frameworks_individual_framework_comps.change_categories_visible?
      # Ok it appears there are categories on this one, lets open up the list and remove them so we can proceed
      cms_frameworks_individual_framework_comps.link_change_categories.click
      expect(page).to have_current_path(%r{/frameworks/frameworks/}, url: true, wait: 10)
      expect(cms_frameworks_individual_fw_categories_comps.text_page_heading_edit.text).to include("Edit Framework Categories")

      # Find and uncheck all checked boxes
      reset_all_checkboxes

      # Save changes and return to the main individual framework screen
      cms_frameworks_individual_fw_categories_comps.button_save_changes.click
      expect(page).to have_current_path(%r{/frameworks/frameworks/}, url: true, wait: 10)
      expect(cms_frameworks_individual_framework_comps.text_page_heading.text).to include(framework_partial_name)
    end

    # Open Add Categories Screen
    cms_frameworks_individual_framework_comps.link_add_categories.click
    expect(page).to have_current_path(%r{/frameworks/frameworks/}, url: true, wait: 10)
    expect(cms_frameworks_individual_fw_categories_comps.text_page_heading_edit.text).to include("Edit Framework Categories")

    # Add new categories
    cms_frameworks_individual_fw_categories_comps.label_audit_accessibility.click
    cms_frameworks_individual_fw_categories_comps.label_breakfast_club.click
    cms_frameworks_individual_fw_categories_comps.label_decarbonisation.click
    cms_frameworks_individual_fw_categories_comps.label_boilers_and_plumbing_services.click
    cms_frameworks_individual_fw_categories_comps.label_av_displays.click
    cms_frameworks_individual_fw_categories_comps.label_consultancy.click
    cms_frameworks_individual_fw_categories_comps.label_water.click
    cms_frameworks_individual_fw_categories_comps.button_save_changes.click
    expect(page).to have_current_path(%r{/frameworks/frameworks/}, url: true, wait: 10)
    expect(cms_frameworks_individual_framework_comps.text_page_heading.text).to include(framework_partial_name)

    # Validate that these categories have appeared on the framework
    cms_frameworks_individual_framework_comps.text_applied_category_name("Audit Accessibility (buildings and digital)")
    cms_frameworks_individual_framework_comps.text_applied_category_name("Breakfast Club")
    cms_frameworks_individual_framework_comps.text_applied_category_name("Decarbonisation")
    cms_frameworks_individual_framework_comps.text_applied_category_name("Boilers and plumbing services")
    cms_frameworks_individual_framework_comps.text_applied_category_name("AV Displays")
    cms_frameworks_individual_framework_comps.text_applied_category_name("Consultancy")
    cms_frameworks_individual_framework_comps.text_applied_category_name("Water")
  end

  def remove_all_existing_categories
    # Our Framework should include the name "Auto Test Solution"
    framework_partial_name = "Auto Test Solution"

    # Open category list and remove any active ones
    cms_frameworks_individual_framework_comps.change_categories_visible?
    cms_frameworks_individual_framework_comps.link_change_categories.click
    expect(page).to have_current_path(%r{/frameworks/frameworks/}, url: true, wait: 10)
    expect(cms_frameworks_individual_fw_categories_comps.text_page_heading_edit.text).to include("Edit Framework Categories")

    # Find and uncheck all checked boxes
    reset_all_checkboxes

    # Save changes and return to the main individual framework screen
    cms_frameworks_individual_fw_categories_comps.button_save_changes.click
    expect(page).to have_current_path(%r{/frameworks/frameworks/}, url: true, wait: 10)
    expect(cms_frameworks_individual_framework_comps.text_page_heading.text).to include(framework_partial_name)
    expect(cms_frameworks_individual_framework_comps.link_framework_details.text).to include("Framework Details")
  end

  def confirm_categories_are_no_longer_associated_with_framework
    expect(cms_frameworks_individual_framework_comps.link_framework_details.text).to include("Framework Details")
    expect(cms_frameworks_individual_framework_comps.no_applied_category_name?("Books")).to be true
    expect(cms_frameworks_individual_framework_comps.no_applied_category_name?("Audit Accessibility (buildings and digital)")).to be true
    expect(cms_frameworks_individual_framework_comps.no_applied_category_name?("Breakfast Club")).to be true
    expect(cms_frameworks_individual_framework_comps.no_applied_category_name?("Decarbonisation")).to be true
    expect(cms_frameworks_individual_framework_comps.no_applied_category_name?("Boilers and plumbing services")).to be true
    expect(cms_frameworks_individual_framework_comps.no_applied_category_name?("AV Displays")).to be true
    expect(cms_frameworks_individual_framework_comps.no_applied_category_name?("Consultancy")).to be true
    expect(cms_frameworks_individual_framework_comps.no_applied_category_name?("Water")).to be true
  end

  def leave_and_return_to_the_current_active_framework
    # Store current framework title
    current_framework_title = cms_frameworks_individual_framework_comps.text_page_heading.text

    # Navigate back to the main Framework Register page
    # Note ES-1142 is a defect that is linked to the below code and why we need a
    # double click of the back button for this to work as desired.
    expect(cms_frameworks_individual_framework_comps.link_framework_details.text).to include("Framework Details")
    cms_frameworks_individual_framework_comps.link_back_button.click

    unless page.has_current_path?(%r{/frameworks#frameworks-register}, url: true, wait: 2) ||
        page.has_current_path?(%r{frameworks_filter}, url: true, wait: 2)
      cms_frameworks_individual_framework_comps.link_back_button.click
      cms_frameworks_individual_framework_comps.link_back_button.click
    end

    expect(page).to have_current_path(%r{frameworks_filter}, url: true, wait: 2)
    expect(cms_frameworks_register_comps.text_page_heading.text).to include("Frameworks Register")

    # Find and select our Auto Test Solution framework from the list / narrow down the options
    cms_frameworks_register_comps.input_search.set(current_framework_title)
    cms_frameworks_register_comps.input_search.send_keys(:enter)
    sleep(1)

    # Confirm the status us "DfE approved"
    cms_frameworks_register_comps.checkbox_status_dfe_approved.click

    # Open the framework / Validate the framework has correctly loaded (Note this was a previous defect)
    cms_frameworks_register_comps.link_internal_framework_ref_partial_name(current_framework_title).click
    expect(page).to have_current_path(%r{/frameworks/frameworks/}, url: true, wait: 10)
    expect(cms_frameworks_individual_framework_comps.text_page_heading.text).to include(current_framework_title)
  end
end
