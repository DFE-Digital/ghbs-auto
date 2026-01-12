# frozen_string_literal: true

class EnergyVatCertificateComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  # VAT certificate of declaration
  def checkbox_1
    find(:xpath, "//input[@id='vat-certificate-form-vat-certificate-declared-declaration1-field']")
  end

  def checkbox_2
    find(:xpath, "//input[@id='vat-certificate-form-vat-certificate-declared-declaration2-field']")
  end

  def checkbox_3
    find(:xpath, "//input[@id='vat-certificate-form-vat-certificate-declared-declaration3-field']")
  end

  # Form completion
  def button_save_and_continue
    find(:xpath, "//input[@type='submit' and @value='Save and continue']")
  end

  def link_go_to_task_list
    find(:xpath, "//a[text()='Discard and go to task list']")
  end
end
