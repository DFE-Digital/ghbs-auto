# frozen_string_literal: true

class CmsTopNavComps
  include Capybara::DSL

  def link_notifications
    find(:xpath, "//a[text()='Notifications']")
  end

  def link_case_statistics
    find(:xpath, "//a[text()='Case Statistics']")
  end

  def link_management
    find(:xpath, "//a[text()='Management']")
  end

  def link_my_cases
    find(:xpath, "//a[text()='My cases']")
  end

  def link_find_a_case
    find(:xpath, "//a[text()='Find a case']")
  end

  def link_frameworks
    find(:xpath, "//a[text()='Frameworks']")
  end

  def link_sign_out
    find(:xpath, "//a[text()='Sign out']")
  end
end
