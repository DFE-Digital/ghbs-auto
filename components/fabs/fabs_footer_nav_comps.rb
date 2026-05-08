# frozen_string_literal: true

class FabsFooterNavComps
  include Capybara::DSL

  # Links
  def link_accessibility_statement
    find(:xpath, "//a[text()='Accessibility statement']")
  end

  def link_terms_and_conditions
    find(:xpath, "//a[text()='Terms and conditions']")
  end

  def link_privacy_notice
    find(:xpath, "//a[text()='Privacy notice']")
  end
end
