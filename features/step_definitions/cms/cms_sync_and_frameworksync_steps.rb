# frozen_string_literal: true

And(/^trigger the Synchronization job$/) do
  cms_management_sync_frameworks_methods.run_the_sync_job
end

Then(/^the changes contentful framework changes will be reflected in the Frameworks Register$/) do
  cms_frameworks_methods.validate_the_contentful_framework_has_been_updated
end

When(/^we navigate the Frameworks Register opening the first DfE approved record$/) do
  cms_frameworks_methods.nav_to_frameworks_and_open_first_dfe_approved
end
