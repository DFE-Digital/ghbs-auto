# frozen_string_literal: true

require "capybara/dsl"
require "rspec/expectations"
require "features/support/shared_cms_comps"
require "features/support/a11y_assertions"

class CmsBasePage
  include Capybara::DSL
  include RSpec::Matchers
  include SharedCmsComps
  include A11yAssertions
end
