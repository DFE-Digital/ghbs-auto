# frozen_string_literal: true

class CmsEvalEmailEvaluatorsComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "h1")
  end

  def text_sharing_with_email_list(email_address)
    find(:xpath, "//h2[text()='Sharing with']/following-sibling::dl//dd[contains(.,'#{email_address}')]")
  end

  def text_docs_uploaded_list(uploaded_doc)
    find(:xpath, "//h2[text()='Documents']/following-sibling::dl//dd[contains(.,'#{uploaded_doc}')]")
  end

  def link_unique_case_specific_link
    find(:xpath, "//a[contains(.,'unique case-specific link')]")
  end

  def link_attachments_added(attached_files)
    find(:xpath, "//h2[text()='Attachments added']/following-sibling::div//span[contains(.,'#{attached_files}')]")
  end

  def button_cancel
    find(:xpath, "//a[text()='Cancel']")
  end

  def button_send_email_and_continue
    find(:xpath, "//input[@value='Send email and continue']")
  end
end
