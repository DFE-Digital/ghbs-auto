# frozen_string_literal: true

require "capybara/dsl"
require "rspec/expectations"
require "features/support/shared_cms_comps"
require "features/support/a11y_assertions"
require "features/support/shared_signin_comps"
require "pages/shared_global_methods"

class CmsBasePage
  include Capybara::DSL
  include RSpec::Matchers
  include SharedCmsComps
  include SharedDfeSignInComps
  include A11yAssertions

  # Provides access to shared global page methods (e.g. DfE sign-in helpers)
  def shared_global_methods
    @shared_global_methods ||= SharedGlobalMethods.new
  end
end
