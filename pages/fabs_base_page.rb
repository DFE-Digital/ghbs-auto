require 'capybara/dsl'
require 'rspec/expectations'
require_relative '../features/support/shared_fabs_comps'

class FabsBasePage
  include Capybara::DSL
  include RSpec::Matchers
  include SharedFabsComps
end
