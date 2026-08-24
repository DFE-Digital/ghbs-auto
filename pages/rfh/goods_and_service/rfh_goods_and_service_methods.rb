# frozen_string_literal: true

require "pages/shared/shared_global_methods"
require "pages/rfh/rfh_base_page"
require "components/rfh/goods_or_services/rfh_what_type_of_goods_and_services_comps"
require "components/rfh/goods_or_services/rfh_approx_how_much_comps"
require "components/rfh/goods_or_services/rfh_how_can_we_help_comps"
require "helpers/login_helpers"
require "helpers/validation_helpers"
require "helpers/logger_helpers"
require "helpers/unique_content_helpers"

class RfhGoodsAndServiceMethods < RfhBasePage
  include LoginHelpers
  include ValidationHelpers
  include LoggerHelpers
  include UniqueContentHelpers

  def select_goods_or_service(good_or_service)
    # Confirm we are on the "What type of goods or service do you need?" screen
    expect(page).to have_current_path(%r{/procurement-support/categories}, url: true, wait: 10)
    expect(rfh_what_type_of_goods_and_services_comps.text_page_heading.text).to include("What type of goods or service do you need?")

    case good_or_service
    when "goods"
      # Select the "Furniture" option as it's the quickest path for a good type.
      rfh_what_type_of_goods_and_services_comps.radio_furniture.click
      rfh_what_type_of_goods_and_services_comps.button_continue.click

      # Store our info so far in the rfh_state dto to be validated against as we move through the app
      rfh_state.type_of_goods_or_service = "Furniture"

      complete_approx_how_much_screen
      complete_how_can_we_help_screen
    when "service"
      # TODO
    else
      log.error "Your step is lacking a 'goods' or 'service' definition in its step!"
    end
  end

  def complete_approx_how_much_screen
    # Confirm we are on the "Approximately how much will the school be spending on this procurement in total?" screen
    expect(page).to have_current_path(%r{/procurement-support/procurement_amount}, url: true, wait: 10)
    expect(rfh_approx_how_much_comps.text_page_heading.text).to include("Approximately how much will the school be spending on this procurement in total?")

    # Enter an amount and continue on to the next screen
    proc_amount = "20000"
    rfh_approx_how_much_comps.input_amount.set(proc_amount)

    # Store our info so far in the rfh_state dto to be validated against as we move through the app
    rfh_state.procurement_amount = proc_amount

    # Move on to the next screen
    rfh_approx_how_much_comps.button_continue.click
  end

  def complete_how_can_we_help_screen
    # Confirm we are on the "How can we help?" screen
    expect(page).to have_current_path(%r{/procurement-support/message}, url: true, wait: 10)
    expect(rfh_how_can_we_help_comps.text_page_heading.text).to include("How can we help?")

    # Enter an amount and continue on to the next screen
    how_can_we_help_message = "How help: This is an auto test at #{Time.now}"
    rfh_how_can_we_help_comps.input_info_text.set(how_can_we_help_message)

    # Store our info so far in the rfh_state dto to be validated against as we move through the app
    rfh_state.description_of_request = how_can_we_help_message

    # Move on to the next screen
    rfh_how_can_we_help_comps.button_continue.click
  end
end
