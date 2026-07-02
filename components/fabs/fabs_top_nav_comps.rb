# frozen_string_literal: true

class FabsTopNavComps
  include Capybara::DSL

  def image_dfe_logo
    find(:xpath, "//img[@alt='Department for Education']")
  end
end
