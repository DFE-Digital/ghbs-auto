# frozen_string_literal: true

require "pages/cms/cms_base_page"
require "helpers/validation_helpers"
require "components/cms/utils/flipper_comps"
require "components/cms/case/cms_single_case_messages_comps"
require "components/cms/case/cms_single_case_nav_comps"

class CmsCaseEmailAndFileMethods < CmsBasePage
  include ValidationHelpers

  def validate_dev_fiddler_flag_states
    # remember current url location
    return_url = page.current_url

    # Navigate to and log in to fiddler
    visit SECRETS["dev_flipper_url_pre_authenticated"]

    # Log each of the flag status
    env_state.auto_email_vat_dd = flag_state("auto_email_vat_dd")
    env_state.auto_send_siteAdditions_gas = flag_state("auto_send_siteAdditions_gas")
    env_state.auto_send_siteAdditions_power = flag_state("auto_send_siteAdditions_power")
    env_state.customer_satisfaction_survey = flag_state("customer_satisfaction_survey")
    env_state.energy = flag_state("energy")
    env_state.ghbs_public_frontend = flag_state("ghbs_public_frontend")
    env_state.rfh_usability_survey = flag_state("rfh_usability_survey")
    env_state.sc_tasklist_case = flag_state("sc_tasklist_case")
    env_state.usability_surveys = flag_state("usability_surveys")
    env_state.allow_mat_flow = flag_state("allow_mat_flow")

    # Return to the page we were on befoe leaving to check flipper
    visit return_url
  end

  def validate_emails_for_energy_case
    # NOTE: What appears is based on the feature flags

    # Nav to the messages tab.
    cms_single_case_nav_comps.link_messages.click
    wait_for_element_to_include(cms_single_case_messages_comps.text_messages_sub_heading, "Messages", timeout: 5)

    # Gather all the email titles
    # visible_email_titles = cms_single_case_messages_comps.text_all_email_titles.map { |el| el.text.strip }

    visible_email_titles = wait_for_collection_count_then_capture(expected_count_of_emails: 2, refresh_page_every_x_seconds: 3, last_change_for_emails_to_drop_in: 10, timeout_s: 60) do
      cms_single_case_messages_comps.text_all_email_titles
    end

    # Validate the start email as everyone has this regardless of flags
    # Example: Case 002515 - form started: Energy for Schools
    expect(visible_email_titles).to include("Case #{case_state.case_number} - form started: Energy for Schools")

    if env_state.auto_email_vat_dd == "enabled"
      expect(visible_email_titles).to include("Case #{case_state.case_number} - send your VAT and Direct Debit instructions for gas: Energy for Schools")
      expect(visible_email_titles).to include("Case #{case_state.case_number} - send your VAT and Direct Debit instructions for electricity: Energy for Schools")
    else
      expect(visible_email_titles).not_to include("Case #{case_state.case_number} - send your VAT and Direct Debit instructions for gas: Energy for Schools")
      expect(visible_email_titles).not_to include("Case #{case_state.case_number} - send your VAT and Direct Debit instructions for electricity: Energy for Schools")
    end

    if env_state.auto_send_siteAdditions_gas == "enabled"
      # TODO
    else
      # TODO
    end

    if env_state.auto_send_siteAdditions_power == "enabled"
      # TODO
    else
      # TODO
    end
  end

private

  def flag_state(flag_name)
    xpath = flipper_comps.xpath_flag_name_and_state(flag_name)
    return "disabled" unless page.has_xpath?(xpath, wait: 0.5)

    page.find(:xpath, xpath, wait: 0.5).text.include?("Fully Enabled") ? "enabled" : "disabled"
  end

  def wait_for_collection_count_then_capture(expected_count_of_emails:, refresh_page_every_x_seconds: 2, last_change_for_emails_to_drop_in: 1, timeout_s: 20)
    deadline = Time.now + timeout_s
    current_count = 0

    loop do
      collection = Array(yield)
      current_count = collection.count

      if current_count >= expected_count_of_emails
        sleep last_change_for_emails_to_drop_in
        page.driver.browser.navigate.refresh
        sleep 1
        return Array(yield).map { |el| el.text.strip }
      end

      raise "Timed out after #{timeout_s}s waiting for at least #{expected_count_of_emails} items. Last seen count: #{current_count}" if Time.now >= deadline

      page.driver.browser.navigate.refresh
      sleep refresh_page_every_x_seconds
    end
  end
end
