# frozen_string_literal: true

class CmsMyCasesPageComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def text_flash_notice_content
    find(:xpath, "//div[@id='flash_notice']")
  end

  def button_create_a_new_case
    find(:xpath, "//button[text()='Create a new case']")
  end

  def xpath_link_case(case_number)
    "//dt[contains(.,'Case')]/following-sibling::dd/a[contains(.,'#{case_number}')]"
  end

  def link_case(case_number)
    find(:xpath, xpath_link_case(case_number))
  end

  ### Checkbox level all ###

  def id_checkbox_level_all
    "filter-my-cases-form-level-all-field"
  end

  def xpath_checkbox_level_all
    "//input[@id='#{id_checkbox_level_all}']"
  end

  def checkbox_level_all
    find(:xpath, xpath_checkbox_level_all, visible: :all, wait: 5)
  end

  def label_level_all
    find(:xpath, "//label[@for='#{id_checkbox_level_all}']")
  end

  ### Checkbox level 1 ###

  def id_checkbox_level_1
    "filter-my-cases-form-level-l1-field"
  end

  def xpath_checkbox_level_1
    "//input[@id='#{id_checkbox_level_1}']"
  end

  def checkbox_level_1
    find(:xpath, xpath_checkbox_level_1, visible: :all, wait: 5)
  end

  def label_level_1
    find(:xpath, "//label[@for='#{id_checkbox_level_1}']")
  end

  ### Checkbox level 2 ###

  def id_checkbox_level_2
    "filter-my-cases-form-level-l2-field"
  end

  def xpath_checkbox_level_2
    "//input[@id='#{id_checkbox_level_2}']"
  end

  def checkbox_level_2
    find(:xpath, xpath_checkbox_level_2, visible: :all, wait: 5)
  end

  def label_level_2
    find(:xpath, "//label[@for='#{id_checkbox_level_2}']")
  end

  ### Checkbox level 3 ###

  def id_checkbox_level_3
    "filter-my-cases-form-level-l3-field"
  end

  def xpath_checkbox_level_3
    "//input[@id='#{id_checkbox_level_3}']"
  end

  def checkbox_level_3
    find(:xpath, xpath_checkbox_level_3, visible: :all, wait: 5)
  end

  def label_level_3
    find(:xpath, "//label[@for='#{id_checkbox_level_3}']")
  end

  ### Checkbox level 4 ###

  def id_checkbox_level_4
    "filter-my-cases-form-level-l4-field"
  end

  def xpath_checkbox_level_4
    "//input[@id='#{id_checkbox_level_4}']"
  end

  def checkbox_level_4
    find(:xpath, xpath_checkbox_level_4, visible: :all, wait: 5)
  end

  def label_level_4
    find(:xpath, "//label[@for='#{id_checkbox_level_4}']")
  end

  ### Checkbox level 5 ###

  def id_checkbox_level_5
    "filter-my-cases-form-level-l5-field"
  end

  def xpath_checkbox_level_5
    "//input[@id='#{id_checkbox_level_5}']"
  end

  def checkbox_level_5
    find(:xpath, xpath_checkbox_level_5, visible: :all, wait: 5)
  end

  def label_level_5
    find(:xpath, "//label[@for='#{id_checkbox_level_5}']")
  end

  ### Checkbox level 6 ###

  def id_checkbox_level_6
    "filter-my-cases-form-level-l6-field"
  end

  def xpath_checkbox_level_6
    "//input[@id='#{id_checkbox_level_6}']"
  end

  def checkbox_level_6
    find(:xpath, xpath_checkbox_level_6, visible: :all, wait: 5)
  end

  def label_level_6
    find(:xpath, "//label[@for='#{id_checkbox_level_6}']")
  end

  ### Checkbox level 7 ###

  def id_checkbox_level_7
    "filter-my-cases-form-level-l7-field"
  end

  def xpath_checkbox_level_7
    "//input[@id='#{id_checkbox_level_7}']"
  end

  def checkbox_level_7
    find(:xpath, xpath_checkbox_level_7, visible: :all, wait: 5)
  end

  def label_level_7
    find(:xpath, "//label[@for='#{id_checkbox_level_7}']")
  end
end
