# frozen_string_literal: true

require "pages/fabs/fabs_base_page"
require "components/fabs/fabs_home_comps"
require "components/fabs/fabs_buying_category_comps"
require "components/fabs/fabs_buying_option_comps"
require "components/fabs/fabs_top_nav_comps"
require "components/fabs/fabs_savings_options_for_schools_comps"
require "components/fabs/fabs_insignis_savings_platform_comps"
require "components/fabs/fabs_current_accounts_comps"
require "components/fabs/fabs_shared_related_content_comps"
require "helpers/url_nav_helpers"
require "helpers/api/http_api_helpers"

class FabsBankingMethods < FabsBasePage
  include UrlHelpers
  include HttpApiHelpers

  def open_the_banking_and_finance_category
    # Open up the Recruitment, HR and training buying category
    fabs_home_comps.link_category_banking_and_finance.click
    expect(page).to have_current_path(%r{/categories/banking-finance}, url: true, wait: 10)
    expect(fabs_buying_category_comps.text_page_heading.text).to include("Banking and finance")

    # Open up the Current accounts and savings staffing buying option
    fabs_buying_category_comps.link_buying_category_by_name("Current accounts and savings").click
    expect(page).to have_current_path(%r{/savings-options-for-schools}, url: true, wait: 10)
    expect(fabs_buying_option_comps.text_page_heading.text).to include("Savings options for schools")
  end

  def validate_the_correct_links_on_the_savings_options_page
    # Confirm link to FSCS
    url_fscs = "https://www.fscs.org.uk/what-we-cover/banks-building-societies-credit-unions/"
    expect(page).to have_link("FSCS protected amount of £120,000 (opens in new tab)", href: url_fscs)
    validate_http_response_and_content(url_fscs, 200, "Banks, building societies and credit unions")

    # Confirm link to DfE Banking Comparison Tool
    url_dfe_comp_tool = "https://banking-for-schools.education.gov.uk/site/LEUFJZNSINPDVTWF/index.html"
    expect(page).to have_link("DfE Banking Comparison Tool (opens in new tab)", href: url_dfe_comp_tool)
    validate_http_response_and_content(url_dfe_comp_tool, 200, "Banking comparison tool")

    # Confirm link to Find out more about Insignis (opens in new tab)
    url_insignis = "/insignis-savings-platform"
    expect(page).to have_link("Find out more about Insignis (opens in new tab)", href: url_insignis)

    # Nav to the Find out more about Insignis page
    fabs_savings_options_for_schools_comps.link_find_out_more_about_insignis.click
    expect(page).to have_current_path(%r{/insignis-savings-platform}, url: true, wait: 10)
    expect(fabs_buying_option_comps.text_page_heading.text).to include("Insignis savings platform")
  end

  def validate_the_correct_links_on_the_insignis_page
    # Confirm link to FSCS
    url_fscs = "https://www.fscs.org.uk/"
    expect(page).to have_link("Financial Services Compensation Scheme.", href: url_fscs)
    validate_http_response_and_content(url_fscs, 200, "FSCS protects you when financial firms fail")

    # Confirm link to DfE Banking Comparison Tool
    url_insignis = "https://www.insigniscash.com/schools"
    expect(page).to have_link("Visit the Insignis cash savings platform (opens in new tab)", href: url_insignis)
    validate_http_response_and_content(url_insignis, 200, "Transform your school&#x27;s reserves into resources")

    # Confirm link to Current accounts for schools
    fabs_insignis_savings_platform_comps.link_related_content_current_accounts_for_schools.click
    expect(page).to have_current_path(%r{/current-accounts-for-schools}, url: true, wait: 10)
    expect(fabs_buying_option_comps.text_page_heading.text).to include("Current accounts for schools")
  end

  def validate_the_correct_links_on_the_current_accounts_page
    #### Barclays ####
    # Navigate to the internal Barclays page
    fabs_current_accounts_comps.link_barclays.click
    expect(page).to have_current_path(%r{/barclays}, url: true, wait: 10)
    expect(fabs_buying_option_comps.text_page_heading.text).to include("Barclays")

    # Validate the external Barclays link
    url_barclays = "https://www.barclayscorporate.com/industry-expertise/our-sector-coverage/education/"
    expect(page).to have_link("Visit Barclays’ website", href: url_barclays)
    validate_http_response_and_content(url_barclays, 200, "Across the UK, we are committed to delivering outstanding")

    reset_to_current_accounts_via_related_content

    #### Lloyds Banking Group ####
    # Navigate to the internal Lloyds Banking Group page
    fabs_current_accounts_comps.link_lloyds_banking_group.click
    expect(page).to have_current_path(%r{/lloyds-banking-group}, url: true, wait: 10)
    expect(fabs_buying_option_comps.text_page_heading.text).to include("Lloyds Banking Group")

    # Validate the external Lloyds Banking Group link
    url_lloyds = "https://www.lloydsbank.com/business/industry-expertise/education.html?WT.ac=lloyds-RM_signature-hub-sectors-page-education"
    expect(page).to have_link("Visit Lloyds Banking Group’s website", href: url_lloyds)
    # validate_http_response_and_content(url_lloyds, 200)
    validate_http_response_and_content(url_lloyds, 200, "Dedicated support for schools and academy trusts")


    reset_to_current_accounts_via_related_content

    #### NatWest ####
    # Navigate to the internal NatWest page
    fabs_current_accounts_comps.link_natwest.click
    expect(page).to have_current_path(%r{/natwest}, url: true, wait: 10)
    expect(fabs_buying_option_comps.text_page_heading.text).to include("NatWest")

    # Validate the external NatWest link
    url_natwest = "https://www.natwest.com/business/bank-accounts.html?intcam=PC_HP-B-HI-ATLMettle-DEF-A#switch-offer"
    expect(page).to have_link("Visit NatWest’s website", href: url_natwest)
    validate_http_response_and_content(url_natwest, 200, "Tools to help you grow, all from one bank")

    reset_to_current_accounts_via_related_content

    #### Santander ####
    # Navigate to the internal Santander page
    fabs_current_accounts_comps.link_santander.click
    expect(page).to have_current_path(%r{/santander}, url: true, wait: 10)
    expect(fabs_buying_option_comps.text_page_heading.text).to include("Santander")

    # Validate the external Santander link
    url_santander = "https://www.santander.co.uk/corporate/sectors/education"
    expect(page).to have_link("Visit Santander’s website", href: url_santander)
    validate_http_response_and_content(url_santander, 200, "Education | Santander Corporate and Commercial Banking")

    reset_to_current_accounts_via_related_content

    #### Unity Trust Bank ####
    # Navigate to the internal Unity Trust Bank page
    fabs_current_accounts_comps.link_unity_trust_bank.click
    expect(page).to have_current_path(%r{/unity-trust-bank}, url: true, wait: 10)
    expect(fabs_buying_option_comps.text_page_heading.text).to include("Unity Trust Bank Staging")

    # Validate the external Unity Trust Bank link
    url_unity_bank = "https://www.unity.co.uk/"
    expect(page).to have_link("Visit Unity Trust Bank’s website", href: url_unity_bank)
    validate_http_response_and_content(url_unity_bank, 200, "Banking that makes a positive difference")

  end

  def reset_to_current_accounts_via_related_content
    fabs_shared_related_content_comps.link_related_content_current_accounts_for_schools.click
    expect(page).to have_current_path(%r{/current-accounts-for-schools}, url: true, wait: 10)
    expect(fabs_buying_option_comps.text_page_heading.text).to include("Current accounts for schools")
  end
end
