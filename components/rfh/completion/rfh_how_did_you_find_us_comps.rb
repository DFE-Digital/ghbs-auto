# frozen_string_literal: true

class RfhHowDidYouFindUsComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//legend")
  end

  def link_back
    find(:xpath, "//a[text()='Back']")
  end

  def radio_ive_used_this_service_before
    find(:xpath, "//input[@id='framework-support-form-origin-used-before-field']/following-sibling::label")
  end

  def radio_meeting_or_event
    find(:xpath, "//input[@id='framework-support-form-origin-meeting-or-event-field']/following-sibling::label")
  end

  def radio_dfe_publication
    find(:xpath, "//input[@id='framework-support-form-origin-dfe-publication-field']/following-sibling::label")
  end

  def radio_non_dfe_newsletter
    find(:xpath, "//input[@id='framework-support-form-origin-non-dfe-publication-field']/following-sibling::label")
  end

  def radio_recommendation
    find(:xpath, "//input[@id='framework-support-form-origin-recommendation-field']/following-sibling::label")
  end

  def radio_search_engine
    find(:xpath, "//input[@id='framework-support-form-origin-search-engine-field']/following-sibling::label")
  end

  def radio_social_media
    find(:xpath, "//input[@id='framework-support-form-origin-social-media-field']/following-sibling::label")
  end

  def radio_website
    find(:xpath, "//input[@id='framework-support-form-origin-website-field']/following-sibling::label")
  end

  def radio_other
    find(:xpath, "//label[text()='Please specify']/input[@id='framework-support-form-origin-other-field']/following-sibling::label")
  end

  def button_continue
    find(:xpath, "//input[@value='Continue']")
  end
end
