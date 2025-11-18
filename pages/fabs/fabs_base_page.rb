# frozen_string_literal: true

require_relative "../base_page"
require "capybara/dsl"
require "rspec/expectations"
require "features/support/shared_fabs_comps"
require "features/support/a11y_assertions"

class FabsBasePage < BasePage
  include Capybara::DSL
  include RSpec::Matchers
  include SharedFabsComps
  include A11yAssertions
end
