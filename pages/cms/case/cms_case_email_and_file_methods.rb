# frozen_string_literal: true

require "pages/cms/cms_base_page"
require "helpers/validation_helpers"
require "components/cms/utils/flipper_comps"

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

private

  def flag_state(flag_name)
    xpath = flipper_comps.xpath_flag_name_and_state(flag_name)
    return "disabled" unless page.has_xpath?(xpath, wait: 0.5)

    page.find(:xpath, xpath, wait: 0.5).text.include?("Fully Enabled") ? "enabled" : "disabled"
  end
end
