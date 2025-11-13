# frozen_string_literal: true

require "features/support/dto/case_state"

module WorldCaseState
  # One shared instance per scenario
  def case_state
    @case_state ||= CaseState.new
  end
end

World(WorldCaseState)
