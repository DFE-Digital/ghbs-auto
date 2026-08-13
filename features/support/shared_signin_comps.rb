# frozen_string_literal: true

require_relative "comps_registry"

# Component accessors for all _comps.rb files under components/dfe_signin/
module SharedDfeSignInComps
  CompsRegistry.register(self, "dfe_signin")
end
