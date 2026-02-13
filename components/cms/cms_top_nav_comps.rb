# frozen_string_literal: true

class CmsTopNavComps
  include Capybara::DSL

  def xpath_link_notifications
    "//nav[@aria-label='Menu']//a[text()='Notifications']"
  end

  def link_notifications
    find(:xpath, xpath_link_notifications)
  end

  def xpath_link_case_statistics
    "//nav[@aria-label='Menu']//a[text()='Case Statistics']"
  end

  def link_case_statistics
    find(:xpath, xpath_link_case_statistics)
  end

  def xpath_link_management
    "//nav[@aria-label='Menu']//a[text()='Management']"
  end

  def link_management
    find(:xpath, xpath_link_management)
  end

  def xpath_link_my_cases
    "//nav[@aria-label='Menu']//a[text()='My cases']"
  end

  def link_my_cases
    find(:xpath, xpath_link_my_cases)
  end

  def xpath_link_my_cases_e_and_o
    "//nav[@aria-label='Menu']//a[text()='Cases']"
  end

  def link_my_cases_e_and_o
    find(:xpath, xpath_link_my_cases_e_and_o)
  end

  def xpath_link_find_a_case
    "//nav[@aria-label='Menu']//a[text()='Find a case']"
  end

  def link_find_a_case
    find(:xpath, xpath_link_find_a_case)
  end

  def xpath_link_frameworks
    "//nav[@aria-label='Menu']//a[text()='Frameworks']"
  end

  def link_frameworks
    find(:xpath, xpath_link_frameworks)
  end

  def link_sign_out
    find(:xpath, "//nav[@aria-label='Menu']//a[text()='Sign out']")
  end

  # This is only shown when we click on a link and dont have access ie
  # You are not authorised to access that page.
  def link_go_home
    find(:xpath, "//a[contains(.,'Go Home')]")
  end

  def text_not_auth_header
    find(:xpath, "//h1")
  end
end
