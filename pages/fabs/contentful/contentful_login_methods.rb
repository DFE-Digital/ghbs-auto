# frozen_string_literal: true

require "pages/fabs/fabs_base_page"
require "helpers/url_nav_helpers"
require "components/fabs/contentful/contentful_cms_login_comps"
require "components/fabs/contentful/contentful_cms_login_landing_page_comps"

class ContentfulLoginMethods < FabsBasePage
  include UrlHelpers

  def login_to_contentful
    # Navigate to the contentful homepage
    visit SECRETS["contentful_signin_url"]
    expect(page).to have_current_path(%r{/login}, url: true, wait: 10)
    expect(contentful_cms_login_comps.text_page_heading.text).to include("Welcome back")

    # Enter auto test user details
    contentful_cms_login_comps.input_email_address.set(SECRETS["contentful_test_user_login"])
    contentful_cms_login_comps.input_password.set(SECRETS["contentful_test_user_password"])
    contentful_cms_login_comps.button_login.click

    # Confirm you have landed in the GHBS space
    expect(page).to have_current_path(%r{/spaces}, url: true, wait: 10)
    # expect(text_page_heading.text_page_heading.text).to include("GHBS Self-serve")
  end

  def change_to_the_test_env
    # Choose the test env
    visit SECRETS["contentful_test_env"]
    expect(page).to have_current_path(%r{/environments/master/views/entries}, url: true, wait: 10)

    # Double check env in the top right info dropdown
    contentful_cms_login_landing_page_comps.text_current_environment_part_1
    contentful_cms_login_landing_page_comps.text_current_environment_part_2
  end
end
