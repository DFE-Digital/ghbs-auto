# frozen_string_literal: true

module FlagsGlobalConfig
module_function

  def bool_check(val)
    %w[1 true yes on].include?(val.to_s.downcase)
  end

  # Selenium Axe Config
  def axe_enabled?
    bool_check(ENV.fetch("AXE", "false"))
  end
end
