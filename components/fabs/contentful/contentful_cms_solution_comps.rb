# frozen_string_literal: true

class ContentfulCmsSolutionComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def input_title
    find(:xpath, "//input[@id='field-title-en-US']")
  end

  def input_description
    find(:xpath, "//textarea[@data-test-id='cf-ui-textarea']")
  end

  def input_expiry
    find(:xpath, "//input[@data-test-id='cf-ui-datepicker-input']")
  end

  def input_summary
    find(:xpath, "xxx") # TBC - This isn't handled in a standard way.
  end

  def radio_dfe_buying_solution_yes
    find(:xpath, "//input[@id='entity.buying_option_type.en-US.true.6zpl8S']/parent::label")
  end

  def radio_dfe_buying_solution_no
    find(:xpath, "//input[@id='entity.buying_option_type.en-US.false.FbkqRI']/parent::label")
  end

  def input_provider_name
    find(:xpath, "//input[@id='field-provider_name-en-US']")
  end

  def input_provider_reference
    find(:xpath, "//input[@id='field-provider_reference-en-US']")
  end

  def input_url
    find(:xpath, "//input[@id='field-url-en-US']")
  end

  def input_slug
    find(:xpath, "//input[@id='field-slug-en-US']")
  end

  def input_call_to_action
    find(:xpath, "//input[@id='field-call_to_action-en-US']")
  end

  def input_provider_initials
    find(:xpath, "//input[@id='field-provider_initials-en-US']")
  end

  def button_publish_changes
    find(:xpath, "//button[@id='status-widget-primary-action']")
  end

  def text_current_status
    find(:xpath, "//h2[text()='Status']/parent::header/following-sibling::div[1]/span/following-sibling::div/span")
  end
end
