# frozen_string_literal: true

class FabsTopNavComps
  include Capybara::DSL

  def image_dfe_logo
    find(:xpath, "//a[@aria-label='DfE homepage']")
  end
end
