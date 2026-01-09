# frozen_string_literal: true

class FrameworkState
  # We keep an explicit list of attributes instead of introspecting
  # setter methods. Introspection via instance_methods(false) can be
  # fragile and lead to subtle overwrites or unexpected behavior.
  # Note: This list is the single source of truth for what this state holds.
  ATTRS = %i[
    title
    description
    expiry_date
    summary
    dfe_buying_solution
    primary_category
    all_categories
    sub_categories
    related_content
    suffix
    provider_name
    provider_ref
    url
    slug
    cta
    provider_initials
    contentful_id
  ].freeze

  # Create getters and setters for all framework attributes
  attr_accessor(*ATTRS)

  def initialize
    # Initialize all attributes to empty strings so we always have
    # predictable, serializable values (no nils).
    ATTRS.each do |attr|
      instance_variable_set("@#{attr}", "")
    end
  end

  # Bulk update helper
  #
  # Example:
  #   framework_state.update(
  #     title: "My title",
  #     provider_ref: "ABC-123"
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
  #     title: "My title",
  #     provider_ref: "ABC-123",
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
