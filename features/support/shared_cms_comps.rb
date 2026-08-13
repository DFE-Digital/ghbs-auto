# frozen_string_literal: true

require_relative "comps_registry"

# Component accessors for all _comps.rb files under components/cms/
module SharedCmsComps
  CompsRegistry.register(self, "cms")
end
