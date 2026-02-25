# frozen_string_literal: true

class CmsMyCasesPageComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
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

  def xpath_checkbox_level_all
    "//input[@id='filter-my-cases-form-level-all-field']"
  end

  def checkbox_level_all
    find(:xpath, xpath_checkbox_level_all, visible: :all, wait: 5)
  end

  def label_level_all
    find(:xpath, "//label[@for='filter-my-cases-form-level-all-field']")
  end

  def xpath_checkbox_level_1
    "//input[@id='filter-my-cases-form-level-l1-field']"
  end

  def checkbox_level_1
    find(:xpath, xpath_checkbox_level_1, visible: :all, wait: 5)
  end

  def label_level_1
    find(:xpath, "//label[@for='filter-my-cases-form-level-l1-field']")
  end

  def xpath_checkbox_level_2
    "//input[@id='filter-my-cases-form-level-l2-field']"
  end

  def checkbox_level_2
    find(:xpath, xpath_checkbox_level_2, visible: :all, wait: 5)
  end

  def label_level_2
    find(:xpath, "//label[@for='filter-my-cases-form-level-l2-field']")
  end

  def xpath_checkbox_level_3
    "//input[@id='filter-my-cases-form-level-l3-field']"
  end

  def checkbox_level_3
    find(:xpath, xpath_checkbox_level_3, visible: :all, wait: 5)
  end

  def label_level_3
    find(:xpath, "//label[@for='filter-my-cases-form-level-l3-field']")
  end

  def xpath_checkbox_level_4
    "//input[@id='filter-my-cases-form-level-l4-field']"
  end

  def checkbox_level_4
    find(:xpath, xpath_checkbox_level_4, visible: :all, wait: 5)
  end

  def label_level_4
    find(:xpath, "//label[@for='filter-my-cases-form-level-l4-field']")
  end

  def xpath_checkbox_level_5
    "//input[@id='filter-my-cases-form-level-l5-field']"
  end

  def checkbox_level_5
    find(:xpath, xpath_checkbox_level_5, visible: :all, wait: 5)
  end

  def label_level_5
    find(:xpath, "//label[@for='filter-my-cases-form-level-l5-field']")
  end

  def xpath_checkbox_level_6
    "//input[@id='filter-my-cases-form-level-l6-field']"
  end

  def checkbox_level_6
    find(:xpath, xpath_checkbox_level_6, visible: :all, wait: 5)
  end

  def label_level_6
    find(:xpath, "//label[@for='filter-my-cases-form-level-l6-field']")
  end

  def xpath_checkbox_level_7
    "//input[@id='filter-my-cases-form-level-l7-field']"
  end

  def checkbox_level_7
    find(:xpath, xpath_checkbox_level_7, visible: :all, wait: 5)
  end

  def label_level_7
    find(:xpath, "//label[@for='filter-my-cases-form-level-l7-field']")
  end
end
