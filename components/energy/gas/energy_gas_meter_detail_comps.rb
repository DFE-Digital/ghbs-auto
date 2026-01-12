# frozen_string_literal: true

class EnergyGasMeterDetailComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def error_summary_present?(wait: 0.5)
    page.has_xpath?("//h2[@class='govuk-error-summary__title']", wait: wait)
  end

  # Add the Meter Point Reference Number (MPRN)
  def input_mprn
    find(:xpath, "//input[@id='energy-gas-meter-mprn-field']")
  end

  # Estimated annual gas usage for this meter, in kilowatt hours (kWh)
  def input_kwh
    find(:xpath, "//input[@id='energy-gas-meter-gas-usage-field']")
  end

  # Form completion
  def button_save_and_continue
    find(:xpath, "//input[@type='submit' and @value='Save and continue']")
  end

  def link_go_to_task_list
    find(:xpath, "//a[text()='Discard and go to task list']")
  end
end
