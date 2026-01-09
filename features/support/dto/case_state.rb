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
# This object is instantiated fresh for each scenario (see world_state.rb).
# -----------------------------------------------------------------------------

class CaseState
  # All stored values are strings (to simplify serialization/logging).
  # This list is the single source of truth for what this case_state holds.
  ATTRS = [
    :user_email,

    # Energy onboarding case
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
    :electric_mpan_usage_kwh_1,
    :electric_mpan_number_2,
    :electric_mpan_half_hourly_meter_2,
    :electric_mpan_half_hourly_meter_kva_2,
    :electric_mpan_half_hourly_meter_data_aggregator_2,
    :electric_mpan_half_hourly_meter_data_collector_2,
    :electric_mpan_half_hourly_meter_meter_operator_2,
    :electric_mpan_usage_kwh_2,
    :electric_mpan_number_3,
    :electric_mpan_half_hourly_meter_3,
    :electric_mpan_half_hourly_meter_kva_3,
    :electric_mpan_half_hourly_meter_data_aggregator_3,
    :electric_mpan_half_hourly_meter_data_collector_3,
    :electric_mpan_half_hourly_meter_meter_operator_3,
    :electric_mpan_usage_kwh_3,
    :electric_mpan_number_4,
    :electric_mpan_half_hourly_meter_4,
    :electric_mpan_half_hourly_meter_kva_4,
    :electric_mpan_half_hourly_meter_data_aggregator_4,
    :electric_mpan_half_hourly_meter_data_collector_4,
    :electric_mpan_half_hourly_meter_meter_operator_4,
    :electric_mpan_usage_kwh_4,
    :electric_mpan_number_5,
    :electric_mpan_half_hourly_meter_5,
    :electric_mpan_half_hourly_meter_kva_5,
    :electric_mpan_half_hourly_meter_data_aggregator_5,
    :electric_mpan_half_hourly_meter_data_collector_5,
    :electric_mpan_half_hourly_meter_meter_operator_5,
    :electric_mpan_usage_kwh_5,
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

    # Generic / Shared case info
    :case_number,
    :case_organisation_name,
    :case_contact_first_name,
    :case_contact_last_name,
    :case_contact_email,
    :case_contact_phone_number,
    :case_contact_extension_number,
    :case_case_origin,
    :case_request_type,
    :case_procurement_sub_category,
    :case_description_of_query,
    :case_procurement_value,
    :case_case_source,
    :case_level,

    # Evaluation case info
    :case_evaluator_1_email,
    :case_evaluation_due_date,
    :case_proc_ops_eval_uploaded_file_name_1,
    :case_school_eval_uploaded_file_name_1,
    :case_eval_case_specific_link,
    :case_evaluation_email_sent,

    # Handover case info
    :case_handover_1_email,
    :case_proc_ops_handover_uploaded_file_name_1,
    :case_handover_case_specific_link,
    :case_handover_email_sent,

    # Generic info
    :search_term,
  ].freeze

  # Create getters and setters for all case attributes
  attr_accessor(*ATTRS)

  def initialize
    # Initialize all fields to empty strings.
    # This avoids nil checks when concatenating or logging values.
    ATTRS.each do |attr|
      instance_variable_set("@#{attr}", "")
    end
  end

  # Accepts a hash of attributes and updates each one if it exists on the object.
  # Example: case_state.update(user_type: "MAT", energy_choice: "gas only")
  # All values are coerced to strings for consistency.
  def update(attrs = {})
    attrs.each do |k, v|
      setter = "#{k}="
      send(setter, v.to_s) if respond_to?(setter)
    end
    self
  end

  # Returns a plain Ruby hash of all instance variables and their values.
  # Example: puts case_state.to_h => {:user_email=>"qa@example.com", :school_name=>"Test School", ...}
  def to_h
    ATTRS.to_h do |attr|
      [attr.to_sym, public_send(attr)]
    end
  end

  # Shorthand string version (mainly for debug logging)
  def to_s
    to_h.inspect
  end
end
