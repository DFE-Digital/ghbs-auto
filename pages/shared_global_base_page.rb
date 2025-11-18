# frozen_string_literal: true

require_relative "./base_page"
require "capybara/dsl"
require "rspec/expectations"
require "features/support/a11y_assertions"
require "features/support/shared_signin_comps"

class SharedGlobalMethodsBasePage < BasePage
  include Capybara::DSL
  include RSpec::Matchers
  include SharedDfeSignInComps
  include A11yAssertions

  def case_state
    # If we have a real world object, delegate to its case_state
    if !world.nil? && !world.equal?(self) && world.respond_to?(:case_state)
      world.case_state
    else
      @case_state ||= CaseState.new
    end
  end
end
