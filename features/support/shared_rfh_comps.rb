# frozen_string_literal: true

require_relative "comps_registry"

# Component accessors for all _comps.rb files under components/rfh/
module SharedFabsComps
  CompsRegistry.register(self, "rfh")
end
