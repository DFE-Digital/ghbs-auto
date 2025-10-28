# frozen_string_literal: true

class CmsTopNavComps
  include Capybara::DSL

  def link_notifications
    find(:xpath, "//a[text()='Notifications']")
  end

  def link_cases
    find(:xpath, "//a[text()='Cases']")
  end

  def link_find_a_case
    find(:xpath, "//a[text()='Find a case']")
  end

  def link_sign_out
    find(:xpath, "//a[text()='Sign out']")
  end
end
