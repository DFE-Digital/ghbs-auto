# frozen_string_literal: true

class CmsHandoverShareContractComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def text_sharing_with_email_list(email_address)
    find(:xpath, "//h2[text()='Sharing with']/following-sibling::dl//dd[contains(.,'#{email_address}')]")
  end

  def text_docs_uploaded_list(uploaded_doc)
    find(:xpath, "//h2[text()='Documents']/following-sibling::dl//dd[contains(.,'#{uploaded_doc}')]")
  end

  def unique_case_specific_link_href
    within_frame("share-handover-html-content-field_ifr") do
      link = find(:xpath, "//a[contains(.,'unique case-specific link')]", visible: :all, wait: 5)
      link[:href]
    end
  end

  def button_cancel
    find(:xpath, "//a[text()='Cancel']")
  end

  def button_send_email_and_continue
    find(:xpath, "//input[@value='Send email and continue']")
  end
end
