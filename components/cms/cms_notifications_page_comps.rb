# frozen_string_literal: true

class CmsNotificationsPageComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def text_evaluation_notification(case_number)
    find(:xpath, "//a[contains(.,'Case #{case_number} - procurement evaluation')]")
  end

  def text_evaluation_notification_school_evaluated(case_number)
    find(:xpath, "//a[contains(.,'Case #{case_number} - procurement evaluation')]/ancestor::td[1]/following-sibling::td[1]/span[contains(.,'< 30 mins ago')]")
  end
end
