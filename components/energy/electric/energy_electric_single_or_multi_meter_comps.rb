# frozen_string_literal: true

class EnergyElectricSingleOrMultiMeterComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  # Is this a single or multi meter site?
  def radio_single
    find(:xpath, "//input[@id='electricity-meter-type-form-electricity-meter-type-single-field']/following-sibling::label")
  end

  def radio_multi
    find(:xpath, "//input[@id='electricity-meter-type-form-electricity-meter-type-multi-field']/following-sibling::label")
  end

  # Form completion
  def button_save_and_continue
    find(:xpath, "//input[@type='submit' and @value='Save and continue']")
  end

  def link_go_to_task_list
    find(:xpath, "//a[text()='Discard and go to task list']")
  end
end
