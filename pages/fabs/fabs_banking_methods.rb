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

  def open_the_dfe_featured_savings_options_for_schools
    # Open the Dfe Featured option "Savings options for schools" from the homepage
    fabs_home_comps.link_dfe_featured_savings_options_for_schools.click
    expect(page).to have_current_path(%r{/current-savings-accounts}, url: true, wait: 10)
    expect(fabs_buying_option_comps.text_page_heading.text).to include("Savings options for schools")
  end

  def validate_the_correct_links_on_the_savings_options_page
    # Confirm link to FSCS
    url_fscs = "https://www.fscs.org.uk/what-we-cover/banks-building-societies-credit-unions/"
    expect(page).to have_link("FSCS protected amount of £120,000 (opens in new tab)", href: url_fscs)
    validate_link_reachable(
      url_fscs,
      expected_title: "See how FSCS protects banks, building societies and credit unions | FSCS",
      expected_status: 200,
      fallback_on: [403],
      only_run_in: "local"
    )

    # Confirm link to DfE Banking Comparison Tool
    url_dfe_comp_tool = "https://banking-for-schools.education.gov.uk/site/LEOULQZMCMW6DDDL/index.html"
    expect(page).to have_link("Use the DfE Banking Comparison Tool (opens in new tab)", href: url_dfe_comp_tool)
    validate_link_reachable(
      url_dfe_comp_tool,
      expected_title: "Before you start - Banking comparison tool - Department for Education",
      expected_status: 200,
      fallback_on: [403],
      only_run_in: "local"
    )

    # Nav to the Find out more about Insignis page
    fabs_savings_options_for_schools_comps.link_find_out_more_about_insignis.click
    expect(page).to have_current_path(%r{/insignis-savings-platform}, url: true, wait: 10)
    expect(fabs_buying_option_comps.text_page_heading.text).to include("Insignis savings platform")
  end

  def validate_the_correct_links_on_the_insignis_page
    # Confirm link to FSCS
    url_fscs = "https://www.fscs.org.uk/"
    expect(page).to have_link("Financial Services Compensation Scheme.", href: url_fscs)
    validate_link_reachable(
      url_fscs,
      expected_title: "Financial Services Compensation Scheme | FSCS",
      expected_status: 200,
      fallback_on: [403],
      only_run_in: "local"
    )

    # Confirm link to DfE Banking Comparison Tool
    url_insignis = "https://www.insigniscash.com/schools"
    expect(page).to have_link("Visit the Insignis cash savings platform (opens in new tab)", href: url_insignis)
    validate_link_reachable(
      url_insignis,
      expected_title: "Schools",
      expected_status: 200,
      fallback_on: [403],
      only_run_in: "local"
    )

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

    reset_to_current_accounts_via_breadcrumb

    #### Lloyds ####
    # Navigate to the internal Lloyds page
    fabs_current_accounts_comps.link_lloyds_banking_group.click
    expect(page).to have_current_path(%r{/lloyds-banking-group}, url: true, wait: 10)
    expect(fabs_buying_option_comps.text_page_heading.text).to include("Lloyds")

    reset_to_current_accounts_via_breadcrumb

    #### NatWest ####
    # Navigate to the internal NatWest page
    fabs_current_accounts_comps.link_natwest.click
    expect(page).to have_current_path(%r{/natwest}, url: true, wait: 10)
    expect(fabs_buying_option_comps.text_page_heading.text).to include("NatWest")

    reset_to_current_accounts_via_breadcrumb

    #### Progressive Building Society ####
    # Navigate to the internal Progressive Building Society page
    fabs_current_accounts_comps.link_progressive_building_society.click
    expect(page).to have_current_path(%r{/progressive-building-society}, url: true, wait: 10)
    expect(fabs_buying_option_comps.text_page_heading.text).to include("Progressive Building Society")

    reset_to_current_accounts_via_breadcrumb

    #### Reliance Bank Limited ####
    # Navigate to the internal Reliance Bank Limited page
    fabs_current_accounts_comps.link_reliance_bank_limited.click
    expect(page).to have_current_path(%r{/reliance-bank-limited}, url: true, wait: 10)
    expect(fabs_buying_option_comps.text_page_heading.text).to include("Reliance Bank Limited")

    reset_to_current_accounts_via_breadcrumb

    #### Santander ####
    # Navigate to the internal Santander page
    fabs_current_accounts_comps.link_santander.click
    expect(page).to have_current_path(%r{/santander}, url: true, wait: 10)
    expect(fabs_buying_option_comps.text_page_heading.text).to include("Santander")

    reset_to_current_accounts_via_breadcrumb

    #### Unity Trust Bank ####
    # Navigate to the internal Unity Trust Bank page
    fabs_current_accounts_comps.link_unity_trust_bank.click
    expect(page).to have_current_path(%r{/unity-trust-bank}, url: true, wait: 10)
    expect(fabs_buying_option_comps.text_page_heading.text).to include("Unity Trust Bank")
  end

  def reset_to_current_accounts_via_breadcrumb
    fabs_shared_related_content_comps.link_breadcrumb.click
    expect(page).to have_current_path(%r{/current-accounts-for-schools}, url: true, wait: 10)
    expect(fabs_buying_option_comps.text_page_heading.text).to include("Current accounts for schools")
  end
end
