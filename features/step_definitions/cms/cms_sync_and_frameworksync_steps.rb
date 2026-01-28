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

And(/^we add multiple new categories to the framework$/) do
  cms_frameworks_methods.add_multiple_test_categories_to_current_framework
end

And(/^we remove all same categories from the framework$/) do
  cms_frameworks_methods.remove_all_existing_categories
end

Then(/^we will see our framework displays no categories$/) do
  cms_frameworks_methods.confirm_categories_are_no_longer_associated_with_framework
end

And(/^we can leave and return to the framework$/) do
  cms_frameworks_methods.leave_and_return_to_the_current_active_framework
end
