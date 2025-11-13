# frozen_string_literal: true

require "capybara/dsl"
require "rspec/expectations"
require "features/support/shared_energy_comps"
require "features/support/a11y_assertions"
require "features/support/shared_signin_comps"
require "pages/shared_global_methods"

class EnergyBasePage
  include Capybara::DSL
  include RSpec::Matchers
  include SharedEnergyComps
  include SharedDfeSignInComps
  include A11yAssertions

  def initialize(world = nil)
    @world = world
  end

  # Provides access to shared global page methods (e.g. DfE sign-in helpers)
  def shared_global_methods
    @shared_global_methods ||= SharedGlobalMethods.new
  end

  def case_state
    # use the World’s case_state if available; fallback helps in unit tests
    if @world.respond_to?(:case_state)
      @world.case_state
    else
      @case_state ||= CaseState.new
    end
  end
end
