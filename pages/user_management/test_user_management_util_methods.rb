# frozen_string_literal: true

require "pages/shared/shared_global_base_page"
require "components/dfe_signin/user_management/dfe_signin_1_manage_users_comps"
require "components/dfe_signin/user_management/dfe_signin_2_select_your_org_comps"
require "components/dfe_signin/user_management/dfe_signin_3_invite_user_comps"
require "components/dfe_signin/user_management/dfe_signin_4_permission_level_comps"
require "components/dfe_signin/user_management/dfe_signin_5_select_services_comps"
require "components/dfe_signin/user_management/dfe_signin_6_review_invite_details_comps"


class TestUserManagementUtilMethods < SharedGlobalMethodsBasePage

  def open_test_manage_users_screen
    visit SECRETS["test_dfe_signin_org_admin_screens"]

    # Navigates user through the DfE sign-in flow to the "My Cases" page
    world.shared_global_methods.complete_dfe_signin_org_management_as("test_server_approver")
    expect(page).to have_current_path(%r{/approvals/users}, url: true, wait: 10)
    expect(dfe_signin_1_manage_users_comps.text_page_heading.text).to include("Manage users")
  end

  def select_org_to_add_user_too(uid_line)
    # Start "Invite a new user" process
    dfe_signin_1_manage_users_comps.link_invite_new_user.click
    expect(page).to have_current_path(%r{/approvals/select-organisation}, url: true, wait: 10)
    expect(dfe_signin_2_select_your_org_comps.text_page_heading.text).to include("Select your Organisation")

    # Select org from the list based on test choice
    dfe_signin_2_select_your_org_comps.text_success_invite(uid_line).click

    # Move on to the next page
    dfe_signin_2_select_your_org_comps.button_continue.click
    expect(page).to have_current_path(%r{/users/new-user}, url: true, wait: 10)
    expect(dfe_signin_3_invite_user_comps.text_page_heading.text).to include("Invite user")
  end

  def complete_invite_user_to_permissions_page(first_name, last_name, email)
    dfe_signin_3_invite_user_comps.input_first_name.set(first_name)
    dfe_signin_3_invite_user_comps.input_last_name.set(last_name)
    dfe_signin_3_invite_user_comps.input_email.set(email)

    # Move on to the next page
    dfe_signin_3_invite_user_comps.button_continue.click

    # At this point one of two screens could be presented "This user has a DfE Sign-in account" or "Permission level"
    # We need to take action accordingly up to the permission screen.

    current_page_title_name = dfe_signin_4_permission_level_comps.text_page_heading.text

    sleep(1)

    if current_page_title_name == "This user has a DfE Sign-in account"
      dfe_signin_4_permission_level_comps.button_continue.click
      expect(page).to have_current_path(%r{/organisation-permissions}, url: true, wait: 10)
      expect(dfe_signin_4_permission_level_comps.text_page_heading.text).to include("Permission level")
    end

    if current_page_title_name == "Permission level"
      expect(page).to have_current_path(%r{/organisation-permissions}, url: true, wait: 10)
      expect(dfe_signin_4_permission_level_comps.text_page_heading.text).to include("Permission level")
    end

    if current_page_title_name == "Invite user"
        if page.has_css?(".govuk-error-summary", wait: 0) || page.has_css?(".govuk-error-message", wait: 0)
          error_text = page.has_css?(".govuk-error-summary", wait: 0) ? find(".govuk-error-summary").text : find(".govuk-error-message").text
          raise "Org already associated with user (cannot continue). UI error: #{error_text}"
        end
        # Re-raise if it wasn't the expected "already associated" case
        raise
    end

    # Now we should be on the permissions page
  end

  def permission_to_completion(level)
    # Screen 4 - Permission level
    if level == "End User"
      dfe_signin_4_permission_level_comps.radio_end_user.click
    end
    if level == "Approver"
      dfe_signin_4_permission_level_comps.radio_approver.click
    end

    # Move on to the next page
    dfe_signin_4_permission_level_comps.button_continue.click

    # Fantastic news, the user doesn't have the case, and we can gho ahead and add it!
    expect(page).to have_current_path(%r{/associate-services}, url: true, wait: 10)
    expect(dfe_signin_5_select_services_comps.text_page_heading.text).to include("Select services")

    # Screen 5 - Select services # Move on to the next page
    dfe_signin_5_select_services_comps.button_continue.click
    expect(page).to have_current_path(%r{/confirm-details}, url: true, wait: 10)
    expect(dfe_signin_6_review_invite_details_comps.text_page_heading.text).to include("Review invite details")
  end

  def review_details_to_completion(user_email)
    # Screen 6 - Review invite details
    dfe_signin_6_review_invite_details_comps.button_submit.click
    expect(page).to have_current_path(%r{/approvals/users}, url: true, wait: 10)
    expect(dfe_signin_1_manage_users_comps.text_page_heading.text).to include("Manage users")
    dfe_signin_1_manage_users_comps.text_success_invite_test_server

  end

end
