# frozen_string_literal: true

class EnergyElectricMpanSummaryComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def text_count_of_mpans
    all(:xpath, "//h1/following-sibling::table//tbody/tr")
  end

  # Add another MPAN
  def link_change(mpan)
    find(:xpath, "//span[contains(.,'#{mpan}')]/parent::a[contains(.,'Change')]")
  end
  # example: //span[contains(.,'1564897894561')]/parent::a[contains(.,'Change')]

  def link_remove(mpan)
    find(:xpath, "//span[contains(.,'#{mpan}')]/parent::a[contains(.,'Remove')]")
  end

  def link_reject_specific_mprn(mpan)
    find(:xpath, "//tr/td[text()='#{mpan}']/following-sibling::td/a[text()='Remove']")
  end

  def text_flash_notice
    find(:xpath, "//div[@id='flash_notice']")
  end

  def button_add_another_mpan
    find(:xpath, "//a[text()='Add another MPAN']")
  end

  # Form completion
  def button_save_and_continue
    find(:xpath, "//a[@id='save_and_continue']")
  end

  def link_go_to_task_list
    find(:xpath, "//a[text()='Discard and go to task list']")
  end
end
