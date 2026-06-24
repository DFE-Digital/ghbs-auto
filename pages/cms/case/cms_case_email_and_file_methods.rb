# frozen_string_literal: true

require "pages/cms/cms_base_page"
require "helpers/validation_helpers"
require "components/cms/utils/flipper_comps"
require "components/cms/case/cms_single_case_messages_comps"
require "components/cms/case/cms_single_case_nav_comps"
require "components/cms/case/cms_single_case_file_comps"
require "components/cms/case/cms_single_case_attachment_comps"

class CmsCaseEmailAndFileMethods < CmsBasePage
  include ValidationHelpers

  def validate_dev_fiddler_flag_states
    # remember current url location
    return_url = page.current_url

    # Navigate to and log in to fiddler
    visit SECRETS["dev_flipper_url_pre_authenticated"]

    # Page validation
    expect(page).to have_current_path(%r{/flipper/features}, url: true, wait: 10)
    wait_for_element_to_include(flipper_comps.text_page_heading, "Features", timeout: 5)

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

    # Return to the page we were on before leaving to check flipper
    visit return_url
  end

  def validate_emails_for_energy_case
    # NOTE: What appears is based on the feature flags

    # Nav to the messages tab.
    cms_single_case_nav_comps.link_messages.click
    wait_for_element_to_include(cms_single_case_messages_comps.text_messages_sub_heading, "Messages", timeout: 5)

    # Axe Check
    axe_check! if FlagsGlobalConfig.axe_enabled?

    # Gather all the email titles
    visible_email_titles = wait_for_collection_count_then_capture(expected_count_of_elements: 2, refresh_page_every_x_seconds: 3, last_change_for_elements_to_drop_in: 15, timeout_s: 60) do
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
      require "date"
      gas_end_date = Date.parse(case_state.gas_current_contract_end_date).to_date
      gas_end_date += 1
      gas_end_date = gas_end_date.strftime("%d %m %Y")
      expect(visible_email_titles).to include("Case #{case_state.case_number} - DfE onboarding forms - #{case_state.school_name} - Gas - Start date #{gas_end_date}")
    else
      expect(visible_email_titles).not_to include("Case #{case_state.case_number} - DfE onboarding forms - #{case_state.school_name} - Gas - Start date #{gas_end_date}")
    end

    if env_state.auto_send_siteAdditions_power == "enabled"
      require "date"
      electric_end_date = Date.parse(case_state.electric_current_contract_end_date).to_date
      electric_end_date += 1
      electric_end_date = electric_end_date.strftime("%d %m %Y")

      expect(visible_email_titles).to include("Case #{case_state.case_number} - DfE onboarding forms - #{case_state.school_name} - Electricity - Start date #{electric_end_date}")
    else
      expect(visible_email_titles).not_to include("Case #{case_state.case_number} - DfE onboarding forms - #{case_state.school_name} - Electricity - Start date #{electric_end_date}")
    end

    # Validate the end email as everyone has this regardless of flags
    expect(visible_email_titles).to include("Case #{case_state.case_number} - form submitted: Energy for Schools")
  end

  def validate_files_for_energy_case
    # NOTE: What appears is based on the feature flags

    # Nav to the Files tab.
    cms_single_case_nav_comps.link_files.click
    wait_for_element_to_include(cms_single_case_file_comps.text_messages_sub_heading, "Case files", timeout: 5)

    # Axe Check
    axe_check! if FlagsGlobalConfig.axe_enabled?

    # Gather all the file names
    visible_file_names = wait_for_collection_count_then_capture(expected_count_of_elements: 4, refresh_page_every_x_seconds: 3, last_change_for_elements_to_drop_in: 5, timeout_s: 60) do
      cms_single_case_file_comps.text_all_file_titles
    end

    # Set date for file generation check
    require "date"
    today = Date.today
    file_date_check = today.strftime("%Y-%m-%d")

    # Validate expected files based on the flags.
    ### env_state.auto_email_vat_dd == "enabled" or not it doesn't matter the files are the same
    # Example: EDF Vat Declaration_002547_2026-04-14.pdf
    expect(visible_file_names).to include("EDF Vat Declaration_#{case_state.case_number}_#{file_date_check}.pdf")

    # Example: TOTAL Declaration of Use Certificate_002547_2026-04-14.pdf
    expect(visible_file_names).to include("TOTAL Declaration of Use Certificate_#{case_state.case_number}_#{file_date_check}.pdf")

    # Example: EDF_Direct_Debit_002547_2026-04-14.pdf
    expect(visible_file_names).to include("EDF_Direct_Debit_#{case_state.case_number}_#{file_date_check}.pdf")

    # Example: TOTAL_Direct_Debit_002547_2026-04-14.pdf
    expect(visible_file_names).to include("TOTAL_Direct_Debit_#{case_state.case_number}_#{file_date_check}.pdf")

    ###  env_state.auto_send_siteAdditions_gas == "enabled" or not it doesn't matter the files are the same
    # Example: TOTAL Site Addition_002547_2026-04-14.xlsx
    expect(visible_file_names).to include("TOTAL Site Addition_#{case_state.case_number}_#{file_date_check}.xlsx")

    # Example: Total portal Access_002547_2026-04-14.xlsx
    expect(visible_file_names).to include("Total portal Access_#{case_state.case_number}_#{file_date_check}.xlsx")

    ###  env_state.auto_send_siteAdditions_power == "enabled" or not it doesn't matter the files are the same
    # Example: EDF Site Addition_002547_2026-04-14.xlsx
    expect(visible_file_names).to include("EDF Site Addition_#{case_state.case_number}_#{file_date_check}.xlsx")

    # Example: EDF Power portal Access_002547_2026-04-14.xlsx
    expect(visible_file_names).to include("EDF Power portal Access_#{case_state.case_number}_#{file_date_check}.xlsx")

    ###  Generated regardless:
    # Example: DfE Energy for Schools Letter of Agreement_002547_2026-04-14.pdf
    expect(visible_file_names).to include("DfE Energy for Schools Letter of Agreement_#{case_state.case_number}_#{file_date_check}.pdf")

    # Example: EFS Summary_002547_2026-04-14.pdf
    expect(visible_file_names).to include("EFS Summary_#{case_state.case_number}_#{file_date_check}.pdf")
  end

  def validate_attachments_for_energy_case
    # NOTE: What appears is based on the feature flags
    # Nav to the Attachments tab.
    cms_single_case_nav_comps.link_attachments.click
    wait_for_element_to_include(cms_single_case_attachment_comps.text_page_heading, "Email attachments", timeout: 5)

    # Axe Check
    axe_check! if FlagsGlobalConfig.axe_enabled?

    # Set date for file generation check
    require "date"
    today = Date.today
    file_date_check = today.strftime("%Y-%m-%d")

    # Gather all the attachment titles
    visible_attachment_titles = wait_for_collection_count_then_capture(expected_count_of_elements: 2, refresh_page_every_x_seconds: 3, last_change_for_elements_to_drop_in: 3, timeout_s: 60) do
      cms_single_case_attachment_comps.text_all_attachment_titles
    end

    if env_state.auto_email_vat_dd == "enabled"
      # Example: EDF Vat Declaration_002547_2026-04-14.pdf
      expect(visible_attachment_titles).to include("EDF Vat Declaration_#{case_state.case_number}_#{file_date_check}.pdf")

      # Example: TOTAL Declaration of Use Certificate_002547_2026-04-14.pdf
      expect(visible_attachment_titles).to include("TOTAL Declaration of Use Certificate_#{case_state.case_number}_#{file_date_check}.pdf")

      # Example: EDF_Direct_Debit_002547_2026-04-14.pdf
      expect(visible_attachment_titles).to include("EDF_Direct_Debit_#{case_state.case_number}_#{file_date_check}.pdf")

      # Example: TOTAL_Direct_Debit_002547_2026-04-14.pdf
      expect(visible_attachment_titles).to include("TOTAL_Direct_Debit_#{case_state.case_number}_#{file_date_check}.pdf")
    end

    if env_state.auto_send_siteAdditions_gas == "enabled"
      # Example: TOTAL Site Addition_002547_2026-04-14.xlsx
      expect(visible_attachment_titles).to include("TOTAL Site Addition_#{case_state.case_number}_#{file_date_check}.xlsx")

      # Example: Total portal Access_002547_2026-04-14.xlsx
      expect(visible_attachment_titles).to include("Total portal Access_#{case_state.case_number}_#{file_date_check}.xlsx")
    else
      # Example: TOTAL Site Addition_002547_2026-04-14.xlsx
      expect(visible_attachment_titles).not_to include("TOTAL Site Addition_#{case_state.case_number}_#{file_date_check}.xlsx")

      # Example: Total portal Access_002547_2026-04-14.xlsx
      expect(visible_attachment_titles).not_to include("Total portal Access_#{case_state.case_number}_#{file_date_check}.xlsx")
    end

    if env_state.auto_send_siteAdditions_power == "enabled"
      # Example: EDF Site Addition_002547_2026-04-14.xlsx
      expect(visible_attachment_titles).to include("EDF Site Addition_#{case_state.case_number}_#{file_date_check}.xlsx")

      # Example: EDF Power portal Access_002547_2026-04-14.xlsx
      expect(visible_attachment_titles).to include("EDF Power portal Access_#{case_state.case_number}_#{file_date_check}.xlsx")
    else
      # Example: EDF Site Addition_002547_2026-04-14.xlsx
      expect(visible_attachment_titles).not_to include("EDF Site Addition_#{case_state.case_number}_#{file_date_check}.xlsx")

      # Example: EDF Power portal Access_002547_2026-04-14.xlsx
      expect(visible_attachment_titles).not_to include("EDF Power portal Access_#{case_state.case_number}_#{file_date_check}.xlsx")
    end

    ###  Generated regardless:
    # Example: DfE Energy for Schools Letter of Agreement_002547_2026-04-14.pdf
    expect(visible_attachment_titles).to include("DfE Energy for Schools Letter of Agreement_#{case_state.case_number}_#{file_date_check}.pdf")

    # Example: EFS Summary_002547_2026-04-14.pdf
    expect(visible_attachment_titles).to include("EFS Summary_#{case_state.case_number}_#{file_date_check}.pdf")
  end

private

  def flag_state(flag_name)
    xpath = flipper_comps.xpath_flag_name_and_state(flag_name)
    return "disabled" unless page.has_xpath?(xpath, wait: 0.5)

    page.find(:xpath, xpath, wait: 0.5).text.include?("Fully Enabled") ? "enabled" : "disabled"
  end
end
