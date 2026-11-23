# frozen_string_literal: true

class CssP8ThankYouComps
  include Capybara::DSL

  # Page: Thank you
  def text_page_heading
    find(:xpath, "//h1")
  end
end
