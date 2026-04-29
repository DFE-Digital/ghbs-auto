# frozen_string_literal: true

class CmsSingleCaseAttachmentComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//div[@id='case-attachments']//h2")
  end

  def text_all_attachment_titles
    all(:xpath, "//div[@id='case-attachments']//table//tr/th//a")
  end
end
