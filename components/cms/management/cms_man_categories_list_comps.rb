# frozen_string_literal: true

class CmsManCategoriesListComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//caption")
  end
end
