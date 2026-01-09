# frozen_string_literal: true

class CmsManagementSyncFrameworkComps < CmsBasePage
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def button_synchronise
    find(:xpath, "//button[text()='Synchronise']")
  end
end
