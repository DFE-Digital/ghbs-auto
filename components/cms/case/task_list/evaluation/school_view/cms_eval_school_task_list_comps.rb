# frozen_string_literal: true

class CmsEvalSchoolTaskListComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "h1")
  end

  def text_case_number_and_school_name
    find(:xpath, "//h1/preceding-sibling::span")
  end

  def link_download_documents
    find(:xpath, "//a[text()='Download documents']")
  end

  def text_download_documents_status
    find(:xpath, "//a[text()='Download documents']/parent::div/following-sibling::div/strong")
  end

  def link_upload_evaluation_scoring_document
    find(:xpath, "//a[text()='Upload evaluation scoring document']")
  end

  def text_upload_evaluation_scoring_document_status
    find(:xpath, "//a[text()='Upload evaluation scoring document']/parent::div/following-sibling::div/strong")
  end

  def link_evaluation_approved_by_dfe
    find(:xpath, "//a[text()='Evaluation approved by DfE']")
  end

  def text_evaluation_approved_by_dfe_status
    find(:xpath, "//a[text()='Evaluation approved by DfE']/parent::div/following-sibling::div/strong")
  end
end
