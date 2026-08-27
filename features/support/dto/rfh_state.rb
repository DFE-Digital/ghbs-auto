# frozen_string_literal: true

class RfhState
  # NOTE: This list is the single source of truth for what this state holds.
  ATTRS = %i[
    single_or_multi
    signed_in_state
    org_name
    school_name
    group_name
    name_and_address
    local_authority
    head_teacher
    phase_of_education
    school_type_1
    school_type_2
    group_type
    ids_urn
    ids_dfe_num
    ids_ukprn
    ids_uid
    your_name
    your_email_address
    type_of_goods_or_service
    procurement_amount
    description_of_request
    accessibility
    origin
    schools_your_buying_for
    contract_length
    contract_start_date
    documents_attached
  ].freeze

  # Create getters and setters for all current user attributes
  attr_accessor(*ATTRS)

  def initialize
    ATTRS.each do |attr|
      instance_variable_set("@#{attr}", "")
    end
  end

  # Bulk update helper
  #
  # Example:
  #   rfh_state.update(
  #     username: "test_user@abc.gov.uk",
  #     role: "ABC-123"
  #   )
  # All values are coerced to strings for consistency.
  def update(attrs = {})
    attrs.each do |key, value|
      setter = "#{key}="
      send(setter, value.to_s) if respond_to?(setter)
    end
    self
  end

  # Convert the framework state into a hash for logging/debugging
  # Example output:
  #   {
  #     username: "test_user@abc.gov.uk",
  #     role: "ABC-123"
  #     ...
  #   }
  def to_h
    ATTRS.to_h do |attr|
      [attr, public_send(attr)]
    end
  end

  # String representation (useful for puts / logs)
  def to_s
    to_h.inspect
  end
end
