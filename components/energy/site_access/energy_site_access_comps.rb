# frozen_string_literal: true

class EnergySiteAccessComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  # Who manages site access and maintenance?
  def input_first_name
    find(:xpath, "//input[@id='site-contact-details-form-site-contact-first-name-field']")
  end

  def input_last_name
    find(:xpath, "//input[@id='site-contact-details-form-site-contact-last-name-field']")
  end

  def input_email
    find(:xpath, "//input[@id='site-contact-details-form-site-contact-email-field']")
  end

  def input_phone
    find(:xpath, "//input[@id='site-contact-details-form-site-contact-phone-field']")
  end

  # Form completion
  def button_save_and_continue
    find(:xpath, "//input[@type='submit' and @value='Save and continue']")
  end

  def link_go_to_task_list
    find(:xpath, "//a[text()='Discard and go to task list']")
  end
end
