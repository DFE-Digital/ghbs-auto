# frozen_string_literal: true

class EnergyElectricMeterDetailComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def error_summary_present?(wait: 0.5)
    page.has_xpath?("//h2[@class='govuk-error-summary__title']", wait: wait)
  end

  # Add the MPAN
  def input_mpan
    find(:xpath, "//input[@id='energy-electricity-meter-mpan-field']")
  end

  # Is this a half-hourly meter?
  def radio_half_hour_yes
    find(:xpath, "//input[@id='energy-electricity-meter-is-half-hourly-true-field']/following-sibling::label")
  end

  def input_half_hour_yes_kva
    find(:xpath, "//input[@id='energy-electricity-meter-supply-capacity-field']")
  end

  def input_half_hour_yes_data_aggregator
    find(:xpath, "//input[@id='energy-electricity-meter-data-aggregator-field']")
  end

  def input_half_hour_yes_data_collector
    find(:xpath, "//input[@id='energy-electricity-meter-data-collector-field']")
  end

  def input_half_hour_yes_meter_operator
    find(:xpath, "//input[@id='energy-electricity-meter-meter-operator-field']")
  end

  def radio_half_hour_no
    find(:xpath, "//input[@id='energy-electricity-meter-is-half-hourly-field']/following-sibling::label")
  end

  # Estimated annual electricity usage, in kilowatt hours (kWh)
  def input_kwh
    find(:xpath, "//input[@id='energy-electricity-meter-electricity-usage-field']")
  end

  # Form completion
  def button_save_and_continue
    find(:xpath, "//input[@type='submit' and @value='Save and continue']")
  end

  def link_go_to_task_list
    find(:xpath, "//a[text()='Discard and go to task list']")
  end
end
