# frozen_string_literal: true

require "uri"
require "helpers/url_nav_helpers"

class FabsBuyingOptionComps
  include Capybara::DSL
  include UrlHelpers

  def text_page_heading
    find(:xpath, "//h1")
  end

  def breadcrumb_trail
    all(".govuk-breadcrumbs__list-item").map do |li|
      a = li.find("a")
      {
        text: a.text.strip,
        href: normalise_path(a[:href]),
        current: li[:'aria-current'] == "page",
      }
    end
  end
end
