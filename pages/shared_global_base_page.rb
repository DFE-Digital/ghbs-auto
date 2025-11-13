# frozen_string_literal: true

require "capybara/dsl"
require "rspec/expectations"
require "features/support/a11y_assertions"
require "features/support/shared_signin_comps"

class SharedGlobalMethodsBasePage
  include Capybara::DSL
  include RSpec::Matchers
  include SharedDfeSignInComps
  include A11yAssertions

  def case_state
    # Use the World’s case_state if available; if not make it.
    if @world.respond_to?(:case_state)
      @world.case_state
    else
      @case_state ||= CaseState.new
    end
  end
end
