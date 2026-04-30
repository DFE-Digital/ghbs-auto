# frozen_string_literal: true

class CmsSingleCaseFileComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//div[@id='case-details']/h2")
  end

  def text_messages_sub_heading
    find(:xpath, "//turbo-frame[@id='case-files-frame']//h2")
  end

  def text_all_file_titles
    all(:xpath, "//div[@id='case-files']//table//tr/th//a")
  end
end
