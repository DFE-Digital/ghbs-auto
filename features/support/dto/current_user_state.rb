# frozen_string_literal: true

class CurrentUserState
  # NOTE: This list is the single source of truth for what this state holds.
  ATTRS = %i[
    user
    role
    env
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
  #   current_user_state.update(
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
