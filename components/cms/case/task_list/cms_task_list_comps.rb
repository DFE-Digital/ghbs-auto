# frozen_string_literal: true

class CmsTaskListComps
  include Capybara::DSL

  def text_section_heading
    find(:xpath, "//div[@id='tasklist']/h2")
  end

  # Complete evaluation
  def text_evaluation_heading
    find(:xpath, "//div[@id='tasklist']/div[1]/div/h3")
  end

  def link_add_evaluators
    find(:xpath, "//a[text()='Add evaluators']")
  end

  def text_add_evaluators_status
    find(:xpath, "//a[text()='Add evaluators']/parent::div/following-sibling::div/strong")
  end

  def link_set_due_date
    find(:xpath, "//a[text()='Set due date']")
  end

  def text_set_due_date_status
    find(:xpath, "//a[text()='Set due date']/parent::div/following-sibling::div/strong")
  end

  def link_upload_documents
    find(:xpath, "//a[text()='Upload documents']")
  end

  def text_upload_documents_status
    find(:xpath, "//a[text()='Upload documents']/parent::div/following-sibling::div/strong")
  end

  def link_email_evaluators
    find(:xpath, "//a[text()='Email evaluators']")
  end

  def text_email_evaluators_status
    find(:xpath, "//a[text()='Email evaluators']/parent::div/following-sibling::div/strong")
  end

  def text_inactive_email_evaluators_status
    find(:xpath, "//div[text()='Email evaluators']/following-sibling::div/strong")
  end

  def link_review_evaluators
    find(:xpath, "//a[text()='Review evaluations']")
  end

  def text_review_evaluators_status
    find(:xpath, "//a[text()='Review evaluations']/parent::div/following-sibling::div/strong")
  end

  def text_inactive_review_evaluators_status
    find(:xpath, "//div[text()='Review evaluations']/following-sibling::div/strong")
  end

  # Share contract and handover document
  def text_handover_heading
    find(:xpath, "//div[@id='tasklist']/div[2]/div/h3")
  end

  def link_add_contract_recipients
    find(:xpath, "//a[text()='Add contract recipients']")
  end

  def text_add_contract_recipients_status
    find(:xpath, "//a[text()='Add contract recipients']/parent::div/following-sibling::div/strong")
  end

  def link_upload_contract_and_handover_document
    find(:xpath, "//a[text()='Upload contract and handover document']")
  end

  def text_upload_contract_and_handover_document_status
    find(:xpath, "//a[text()='Upload contract and handover document']/parent::div/following-sibling::div/strong")
  end

  def link_share_contract_and_handover_document
    find(:xpath, "//a[text()='Share contract and handover document']")
  end

  def text_share_contract_and_handover_document_status
    find(:xpath, "//a[text()='Share contract and handover document']/parent::div/following-sibling::div/strong")
  end

  def link_download_contract_and_handover_document
    find(:xpath, "//a[text()='Download contract and handover document']")
  end

  def text_download_contract_and_handover_document_status
    find(:xpath, "//a[text()='Download contract and handover document']/parent::div/following-sibling::div/strong")
  end
end
