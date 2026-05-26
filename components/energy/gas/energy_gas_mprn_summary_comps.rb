# frozen_string_literal: true

class EnergyGasMPRNSummaryComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  # Add another MPRN
  def link_change(mprn)
    find(:xpath, "//span[contains(.,'#{mprn}')]/parent::a[contains(.,'Change')]")
  end
  # example: //span[contains(.,'568918487')]/parent::a[contains(.,'Change')]

  def link_remove(mprn)
    find(:xpath, "//span[contains(.,'#{mprn}')]/parent::a[contains(.,'Remove')]")
  end

  def button_add_another_mprn
    find(:xpath, "//a[@id='add_another_mprn']")
  end

  # Form completion
  def button_save_and_continue
    find(:xpath, "//a[@id='save_and_continue']")
  end

  def link_go_to_task_list
    find(:xpath, "//a[text()='Discard and go to task list']")
  end

  def text_count_of_mprns
    all(:xpath, "//h1/following-sibling::table//tbody/tr")
  end

  def link_reject_specific_mprn(mprn)
    find(:xpath, "//tr/td[text()='#{mprn}']/following-sibling::td/a[text()='Remove']")
  end

  def text_flash_notice
    find(:xpath, "//div[@id='flash_notice']")
  end

end
