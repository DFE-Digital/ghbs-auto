# frozen_string_literal: true

class CmsSingleCaseMessagesComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def text_messages_sub_heading
    find(:xpath, "//turbo-frame[@id='messages-frame']/h2")
  end

  def link_create_a_new_message_thread
    find(:xpath, "//h2[contains(.,'Messages')]/following-sibling::details[1]//span[contains(.,'Create a new message thread')]")
  end

  def button_create_with_an_email_template
    find(:xpath, "//h2[contains(.,'Messages')]/following-sibling::details[1]/div//a[contains(.,'Create with an email template')]")
  end

  def button_create_using_a_sig_template
    find(:xpath, "//h2[contains(.,'Messages')]/following-sibling::details[1]/div//button[contains(.,'Create using a signatory template')]")
  end

  def button_send_message
    find(:xpath, "//input[@value='Send message']")
  end
end
