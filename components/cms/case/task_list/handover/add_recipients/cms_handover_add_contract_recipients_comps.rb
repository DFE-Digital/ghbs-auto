# frozen_string_literal: true

class CmsHandoverAddContractRecipientsComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def link_change(username)
    find(:xpath, "//td[text()='#{username}']/following-sibling::td/a")
  end

  def text_evaluator_email_address(email_address)
    find(:xpath, "//tbody/tr/td[2][contains(.,'#{email_address}')]")
  end

  def text_evaluator_name(name)
    find(:xpath, "//tbody/tr/td[1][contains(.,'#{name}')]")
  end

  def button_back
    find(:xpath, "//a[text()='Back']")
  end

  def button_add
    find(:xpath, "//a[text()='Add']")
  end
end
