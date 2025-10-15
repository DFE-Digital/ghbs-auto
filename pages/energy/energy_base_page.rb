# frozen_string_literal: true

require "capybara/dsl"
require "rspec/expectations"
require "features/support/shared_energy_comps"
require "features/support/a11y_assertions"

class EnergyBasePage
  include Capybara::DSL
  include RSpec::Matchers
  include SharedEnergyComps
  include A11yAssertions
end
