# frozen_string_literal: true

require_relative "../base_page"
require "capybara/dsl"
require "rspec/expectations"
require "features/support/shared_cms_comps"
require "features/support/a11y_assertions"
require "features/support/shared_signin_comps"
require "features/support/shared_energy_comps"

class CmsBasePage < BasePage
  include Capybara::DSL
  include RSpec::Matchers
  include SharedCmsComps
  include SharedDfeSignInComps
  include A11yAssertions
  include SharedEnergyComps

  def case_state
    # use the World’s case_state if available; fallback helps in unit tests
    if @world.respond_to?(:case_state)
      @world.case_state
    else
      @case_state ||= CaseState.new
    end
  end
end
