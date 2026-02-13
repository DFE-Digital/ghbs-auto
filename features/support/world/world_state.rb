# frozen_string_literal: true

require "features/support/dto/case_state"
require "features/support/dto/framework_state"
require "features/support/dto/current_user_state"

module WorldState
  # One shared instance per scenario
  def case_state
    @case_state ||= CaseState.new
  end

  def framework_state
    @framework_state ||= FrameworkState.new
  end

  def current_user_state
    @current_user_state ||= CurrentUserState.new
  end
end
