# frozen_string_literal: true

require_relative "fabs/fabs_base_page"

class SharedGlobalMethods < FabsBasePage
  def set_axe_enabled(axe_status)
    ENV["AXE"] = axe_status ? "true" : "false"
  end
end
