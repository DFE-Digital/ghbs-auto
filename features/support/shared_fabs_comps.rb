# frozen_string_literal: true

require_relative "comps_registry"

# Component accessors for all _comps.rb files under components/fabs/
module SharedFabsComps
  CompsRegistry.register(self, "fabs")
end
