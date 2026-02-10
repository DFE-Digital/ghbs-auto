# frozen_string_literal: true

class CmsTopNavComps
  include Capybara::DSL

  def link_notifications
    find(:xpath, "//nav[@aria-label='Menu']//a[text()='Notifications']")
  end

  def link_case_statistics
    find(:xpath, "//nav[@aria-label='Menu']//a[text()='Case Statistics']")
  end

  def link_management
    find(:xpath, "//nav[@aria-label='Menu']//a[text()='Management']")
  end

  def xpath_link_my_cases
    "//nav[@aria-label='Menu']//a[text()='My cases']"
  end

  def link_my_cases
    find(:xpath, xpath_link_my_cases)
  end

  def link_find_a_case
    find(:xpath, "//nav[@aria-label='Menu']//a[text()='Find a case']")
  end

  def link_frameworks
    find(:xpath, "//nav[@aria-label='Menu']//a[text()='Frameworks']")
  end

  def link_sign_out
    find(:xpath, "//nav[@aria-label='Menu']//a[text()='Sign out']")
  end
end
