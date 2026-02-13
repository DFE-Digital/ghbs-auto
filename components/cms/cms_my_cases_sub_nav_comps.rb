# frozen_string_literal: true

class CmsMyCasesSubNavComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def xpath_link_my_cases
    "//main[@id='main-content']//a[contains(.,'My cases')]"
  end

  def link_my_cases
    find(:xpath, xpath_link_my_cases)
  end

  def xpath_link_fm
    "//main[@id='main-content']//a[contains(.,'FM')]"
  end

  def link_fm
    find(:xpath, xpath_link_fm)
  end

  def xpath_link_ict
    "//main[@id='main-content']//a[contains(.,'ICT')]"
  end

  def link_ict
    find(:xpath, xpath_link_ict)
  end

  def xpath_link_energy
    "//main[@id='main-content']//a[contains(.,'Energy')]"
  end

  def link_energy
    find(:xpath, xpath_link_energy)
  end

  def xpath_link_services
    "//main[@id='main-content']//a[contains(.,'Services')]"
  end

  def link_services
    find(:xpath, xpath_link_services)
  end

  def xpath_link_triage
    "//main[@id='main-content']//a[contains(.,'Triage')]"
  end

  def link_triage
    find(:xpath, xpath_link_triage)
  end

  def xpath_new_cases
    "//main[@id='main-content']//a[contains(.,'New cases')]"
  end

  def link_new_cases
    find(:xpath, xpath_new_cases)
  end

  def xpath_link_all_cases
    "//main[@id='main-content']//a[contains(.,'All cases')]"
  end

  def link_all_cases
    find(:xpath, xpath_link_all_cases)
  end
end
