# frozen_string_literal: true

class CmsFrameworksRegisterNavComps
  include Capybara::DSL

  def xpath_link_frameworks_register
    "//a[text()='Frameworks Register']"
  end

  def link_frameworks_register
    find(:xpath, xpath_link_frameworks_register)
  end

  def xpath_link_framework_evaluations
    "//a[text()='Framework Evaluations']"
  end

  def link_framework_evaluations
    find(:xpath, xpath_link_framework_evaluations)
  end

  def xpath_link_provider_contacts
    "//a[text()='Provider Contacts']"
  end

  def link_provider_contacts
    find(:xpath, xpath_link_provider_contacts)
  end

  def xpath_link_providers
    "//a[text()='Providers']"
  end

  def link_providers
    find(:xpath, xpath_link_providers)
  end
end
