# frozen_string_literal: true

class FabsInsignisSavingsPlatformComps
  include Capybara::DSL

  # Text
  def text_page_heading
    find(:xpath, "//h1")
  end

  # Inputs
  def link_related_content_current_accounts_for_schools
    find(:xpath, "//h2[text()='Related content']/following-sibling::ul/li/a[text()='Current accounts for schools']")
  end

end
