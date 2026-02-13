# frozen_string_literal: true

class CmsManSyncFrameworkComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def button_synchronise
    find(:xpath, "//button[text()='Synchronise']")
  end

  def text_notice
    find(:xpath, "//div/h2[contains(.,'Notice')]/parent::div/following-sibling::div/h3/div")
  end
end
