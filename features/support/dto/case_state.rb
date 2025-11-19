# frozen_string_literal: true

# -----------------------------------------------------------------------------
# CaseState
#
# This class acts as a lightweight, per-scenario data container (DTO)
# used to store and share state across the test run.
#
# It’s the Ruby equivalent of a C# "Data Transfer Object" (POCO/struct):
#   - All attributes are plain strings for simplicity.
#   - It doesn’t perform validation, persistence, or formatting logic.
#   - It can be read or updated anywhere in the scenario via `case_state`.
#
# Usage examples:
#   case_state.user_email = "qa@example.com"
#   case_state.billing_address = "123 Test Street, Crawley, RH10 1AA"
#
#   # Bulk update
#   case_state.update(user_type: "MAT", energy_choice: "gas only")
#
#   # Debug dump
#   puts case_state.to_h
#
# This object is instantiated fresh for each scenario (see world_case_state.rb).
# -----------------------------------------------------------------------------

class CaseState
  # All stored values are strings (to simplify serialization/logging).
  attr_accessor \
    :user_email,
    :user_type,
    :school_name,
    :energy_choice,
    :gas_current_supplier,
    :gas_current_contract_end_date,
    :gas_single_or_multi_meter,
    :gas_mprn_number_1,
    :gas_mprn_usage_1,
    :gas_mprn_number_2,
    :gas_mprn_usage_2,
    :gas_mprn_number_3,
    :gas_mprn_usage_3,
    :gas_mprn_number_4,
    :gas_mprn_usage_4,
    :gas_mprn_number_5,
    :gas_mprn_usage_5,
    :electric_current_supplier,
    :electric_current_contract_end_date,
    :electric_single_or_multi_meter,
    :electric_mpan_number_1,
    :electric_mpan_half_hourly_meter_1,
    :electric_mpan_half_hourly_meter_kva_1,
    :electric_mpan_half_hourly_meter_data_aggregator_1,
    :electric_mpan_half_hourly_meter_data_collector_1,
    :electric_mpan_half_hourly_meter_meter_operator_1,
    :electric_mpan_usage_1,
    :electric_mpan_number_2,
    :electric_mpan_half_hourly_meter_2,
    :electric_mpan_half_hourly_meter_kva_2,
    :electric_mpan_half_hourly_meter_data_aggregator_2,
    :electric_mpan_half_hourly_meter_data_collector_2,
    :electric_mpan_half_hourly_meter_meter_operator_2,
    :electric_mpan_usage_2,
    :electric_mpan_number_3,
    :electric_mpan_half_hourly_meter_3,
    :electric_mpan_half_hourly_meter_kva_3,
    :electric_mpan_half_hourly_meter_data_aggregator_3,
    :electric_mpan_half_hourly_meter_data_collector_3,
    :electric_mpan_half_hourly_meter_meter_operator_3,
    :electric_mpan_usage_3,
    :electric_mpan_number_4,
    :electric_mpan_half_hourly_meter_4,
    :electric_mpan_half_hourly_meter_kva_4,
    :electric_mpan_half_hourly_meter_data_aggregator_4,
    :electric_mpan_half_hourly_meter_data_collector_4,
    :electric_mpan_half_hourly_meter_meter_operator_4,
    :electric_mpan_usage_4,
    :electric_mpan_number_5,
    :electric_mpan_half_hourly_meter_5,
    :electric_mpan_half_hourly_meter_kva_5,
    :electric_mpan_half_hourly_meter_data_aggregator_5,
    :electric_mpan_half_hourly_meter_data_collector_5,
    :electric_mpan_half_hourly_meter_meter_operator_5,
    :electric_mpan_usage_5,
    :site_contact_first_name,
    :site_contact_last_name,
    :site_contact_phone,
    :site_contact_email,
    :vat_rate,
    :vat_qualifying_percentage,
    :vat_reg_number,
    :vat_contact_name,
    :vat_contact_phone,
    :vat_contact_address,
    :vat_certificate_confirmation,
    :billing_how_paid,
    :billing_payment_terms,
    :billing_how_receive,
    :billing_address,
    :case_number

  def initialize
    # Initialise all fields to empty strings.
    # This avoids nil checks when concatenating or logging values.
    self.class.attr_names.each { |attr| instance_variable_set("@#{attr}", "") }
  end

  # Accepts a hash of attributes and updates each one if it exists on the object.
  # Example: case_state.update(user_type: "MAT", energy_choice: "gas only")
  def update(attrs = {})
    attrs.each do |k, v|
      send("#{k}=", v.to_s) if respond_to?("#{k}=")
    end
    self
  end

  # Returns a plain Ruby hash of all instance variables and their values.
  # Example: puts case_state.to_h => {:user_email=>"qa@example.com", :school_name=>"Test School", ...}
  def to_h
    self.class.attr_names.to_h do |attr|
      [attr.to_sym, instance_variable_get("@#{attr}")]
    end
  end

  # Shorthand string version (mainly for debug logging)
  def to_s
    to_h.inspect
  end

  class << self
    # Dynamically discover all attribute names based on defined writers
    def attr_names
      instance_methods(false)
        .grep(/=\z/)
        .map { |m| m.to_s.delete_suffix("=").to_sym }
    end
  end
end
