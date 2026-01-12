# frozen_string_literal: true

class ContentfulCmsSearchComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def link_left_hand_nav_all_content
    find(:xpath, "//button[text()='All content']")
  end

  def input_search_field
    find(:xpath, "//input[@data-test-id='queryInput']")
  end

  def link_select_returned_result(result_to_select)
    find(:xpath, "//a[contains(.,'#{result_to_select}')]")
  end
end
