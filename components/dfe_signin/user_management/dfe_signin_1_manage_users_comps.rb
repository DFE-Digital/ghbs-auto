# frozen_string_literal: true

class DfeSignin1ManageUsersComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def link_invite_new_user
    find(:xpath, "//a[contains(.,'Invite new user')]")
  end

  def text_success_invite(user_email)
    find(:xpath, "//p[contains(.,'Invitation email sent to: #{user_email}')]")
  end

  def text_success_invite_test_server
    find(:xpath, "//p[contains(.,'has been successfully added to')]")
  end
end
