# frozen_string_literal: true

require "capybara/dsl"
require "rspec/expectations"

class BasePage
  include Capybara::DSL
  include RSpec::Matchers

  attr_reader :world

  def initialize(world = nil)
    @world = world || self
  end

  def case_state
    if world && !world.equal?(self) && world.respond_to?(:case_state)
      world.case_state
    else
      @case_state ||= CaseState.new
    end
  end

  def framework_state
    if world && !world.equal?(self) && world.respond_to?(:framework_state)
      world.framework_state
    else
      @framework_state ||= FrameworkState.new
    end
  end

  def current_user_state
    if world && !world.equal?(self) && world.respond_to?(:current_user_state)
      world.current_user_state
    else
      @current_user_state ||= CurrentUserState.new
    end
  end
end
