# frozen_string_literal: true

class CmsHandoverDownloadContractComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def text_case_number_and_school_name
    find(:xpath, "//h1/preceding-sibling::span")
  end

  def link_download_contract_handover_pack
    find(:xpath, "//a[text()='Download contract handover pack']")
  end

  def text_download_contract_handover_pack_status
    find(:xpath, "//a[text()='Download contract handover pack']/parent::div/following-sibling::div/strong")
  end
end
