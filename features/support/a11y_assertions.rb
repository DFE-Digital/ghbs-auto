# frozen_string_literal: true
require "rspec/expectations"
require "axe-rspec"

module A11yAssertions
  # Run an axe-core accessibility check against the current Capybara page.
  #
  # How it works:
  # - We build the `be_axe_clean` matcher, then chain options onto it.
  # - Passing the matcher to `expect(page).to ...` actually runs axe.
  # - If violations exist, RSpec raises an ExpectationNotMetError (test fails).
  #
  # @param scope [String, nil]
  #   CSS selector to LIMIT the scan area. If nil, we auto-pick:
  #   - "main, [role='main']" when present, else fallback to "body".
  #
  # @param exclude [String, Array<String>, nil]
  #   CSS selector(s) to EXCLUDE from the scan (e.g. third-party widgets).
  #   Arrays are joined into a single selector list, e.g. ".ads, iframe.embed".
  #
  # @param rules [Array<String,Symbol>]
  #   Axe rule TAGS to use (not rule IDs). Typical: %w[wcag2a wcag2aa].
  #   You can pass symbols or strings; we normalize to symbols.
  #
  # @return [void] (raises on violations)
  #
  # Notes:
  # - Controlled by the feature toggle: FlagsGlobalConfig.axe_enabled?
  # - Note: Cross-origin iframes cannot be scanned by axe; exclude them if needed.
  # - For “log-only” audits, wrap in `rescue` and attach results instead.
  def axe_check!(scope: nil, exclude: nil, rules: %w[wcag2a wcag2aa])
    return unless FlagsGlobalConfig.axe_enabled?

    # Choose a sensible default scope (main landmark → else whole page)
    selector =
      scope ||
      (page.has_css?('main, [role="main"]', wait: 0) ? 'main, [role="main"]' : 'body')

    # Normalize inputs
    exclude_css = exclude.is_a?(Array) ? exclude.compact.join(", ") : exclude
    rule_syms   = Array(rules).compact.map(&:to_sym)

    # We build the matcher, chaining options as needed
    matcher = Axe::Matchers.be_axe_clean
    matcher = matcher.within(selector)            if selector
    matcher = matcher.excluding(exclude_css)      if exclude_css && !exclude_css.empty?
    matcher = matcher.according_to(*rule_syms)    unless rule_syms.empty?

    # Finally we trigger the audit (runs axe) — fails the test on violations
    expect(page).to matcher
  end
end

