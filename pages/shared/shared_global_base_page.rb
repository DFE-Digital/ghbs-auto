# frozen_string_literal: true

require_relative "../base_page"
require "capybara/dsl"
require "rspec/expectations"
require "features/support/a11y_assertions"
require "features/support/shared_signin_comps"

class SharedGlobalMethodsBasePage < BasePage
  include Capybara::DSL
  include RSpec::Matchers
  include SharedDfeSignInComps
  include A11yAssertions
end
