# frozen_string_literal: true

When(/^I confirm I have a need for "([^"]*)" and complete the associated flow$/) do |good_or_service|
  rfh_goods_and_service_methods.select_goods_or_service(good_or_service)
end
