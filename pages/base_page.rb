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
end
