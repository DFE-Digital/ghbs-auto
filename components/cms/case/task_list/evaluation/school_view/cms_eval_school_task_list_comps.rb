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

  def link_upload_evaluation_scoring_document
    find(:xpath, "//a[text()='Upload evaluation scoring document']")
  end

  def link_evaluation_approved_by_dfe
    find(:xpath, "//a[text()='Evaluation approved by DfE']")
  end
end
