# frozen_string_literal: true

class CmsEvalAddEvaluatorsComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "h1")
  end

  def link_change(username)
    find(:xpath, "//td[text()='#{username}']/following-sibling::td/a")
  end

  def button_back
    find(:xpath, "//a[text()='Back']")
  end

  def button_add
    find(:xpath, "//a[text()='Add']")
  end
end
