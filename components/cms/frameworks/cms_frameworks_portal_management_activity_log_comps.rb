# frozen_string_literal: true

class CmsFrameworksPortalManagementActivityLogComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end
end
