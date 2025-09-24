# frozen_string_literal: true
require "rspec/expectations"
require "axe-rspec"

module A11yAssertions
  # This method runs an axe-core accessibility scan against the current Capybara page and
  # prints a structured, multi-line log (Title, URL, scope, rules, excludes, duration).
  #
  # Behaviour:
  # - If the feature toggle is off (FlagsGlobalConfig.axe_enabled? == false), no scan is run.
  #   An “[AXE SKIP]” block is logged (unless `log: false`) and the method returns.
  # - Otherwise we build the `be_axe_clean` matcher and chain options:
  #     scope       - Limit scan area
  #     exclude     - Ignore selectors (e.g., third-party widgets, cross-origin iframes).
  #     *rules      - Axe rule *tags* (not rule IDs). Typical: %w[wcag2a wcag2aa].
  #     label       - Optional free-text label shown in the log for extra context (e.g., "Footer > Terms").
  #     log         - Set false to suppress console output (scan still runs unless disabled).
  #     strip_query - Sets if we show the /search?query= or /search in the logs depending on the sensitivity of data.
  #   On fail, we log an “[AXE FAIL]” block.
  #   On success, we log an “[AXE PASS]” block with timing.
  # Notes:
  # - Toggled via ENV["AXE"] (read by FlagsGlobalConfig.axe_enabled?).
  # - Axe cannot scan cross-origin iframes; exclude them if present.

  def axe_check!(scope: nil, exclude: nil, rules: %w[wcag2a wcag2aa], label: nil, log: true, strip_query: true)
    title = (page.title || "").strip
    path  = _axe_path(strip_query) # path only

    # SKIP Result
    unless FlagsGlobalConfig.axe_enabled?
      _axe_log(status: "SKIP", title:, path:, scope: nil, rules: nil, exclude: nil, label:, elapsed: nil, log:, reason: "disabled")
      return
    end

    selector =
      scope ||
      (page.has_css?('main, [role="main"]', wait: 0) ? 'main, [role="main"]' : 'body')

    exclude_css = exclude.is_a?(Array) ? exclude.compact.join(", ") : exclude
    rule_syms   = Array(rules).compact.map(&:to_sym)

    matcher = Axe::Matchers.be_axe_clean
    matcher = matcher.within(selector)         if selector
    matcher = matcher.excluding(exclude_css)   if exclude_css && !exclude_css.empty?
    matcher = matcher.according_to(*rule_syms) unless rule_syms.empty?

    started = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    expect(page).to matcher
    elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - started

    # PASS Result
    _axe_log(status: "PASS", title:, path:, scope: selector, rules: rule_syms, exclude: exclude_css, label:, elapsed:, log:)
  rescue RSpec::Expectations::ExpectationNotMetError => e
    elapsed = begin
      (started ? Process.clock_gettime(Process::CLOCK_MONOTONIC) - started : nil)
    rescue StandardError
      nil
    end
    # FAIL Result
    _axe_log(status: "FAIL", title:, path:, scope: selector, rules: rule_syms, exclude: exclude_css, label:, elapsed:, log:)
    raise e
  end

  # NOTE: This returns a safe, relative path (no host). If BASE_URL is set, strip it.
  def _axe_path(strip_query)
    raw = begin
      (respond_to?(:current_url) ? current_url : "")
    rescue StandardError
      ""
    end
    return "-" if raw.to_s.empty?

    base = if defined?(FlagsGlobalConfig) && FlagsGlobalConfig.respond_to?(:base_url)
             FlagsGlobalConfig.base_url
           else
             ENV["BASE_URL"]
           end

    if base && !base.to_s.empty? && raw.start_with?(base)
      rel = raw.sub(base, "")
      rel = "/#{rel}" unless rel.start_with?("/")
      return strip_query ? rel.split("?", 2).first : rel
    end

    begin
      uri = URI.parse(raw)
      pth = strip_query ? uri.path : uri.request_uri # request_uri includes ?query
      pth = "/" if pth.nil? || pth.empty?
      pth.squeeze("/") # collapse // to /
    rescue StandardError
      raw # fallback
    end
  end

  # This is a multi-line console logger used by `axe_check!`.
  # example:
  #   [AXE PASS]
  #     Page Title : Home – GHBS
  #     URL        : https://dev.example/
  #     Scope      : main
  #     Rules      : wcag2a,wcag2aa
  #     Exclude    : .cookie-banner
  #     Duration   : 0.21s
  #     Label      : Footer > Terms
  #     Reason     : disabled           # only for SKIP
  def _axe_log(status:, title:, path:, scope:, rules:, exclude:, label:, elapsed:, log:, reason: nil)
    return unless log

    color = { "PASS" => 32, "FAIL" => 31, "SKIP" => 33 }[status] || 0
    header = "[AXE #{status}]"
    header = "\e[#{color}m#{header}\e[0m" if $stdout.tty?

    lines = []
    lines << header
    lines << "  Page Title : #{title.empty? ? "-" : title}"
    lines << "  Path       : #{path.to_s.empty? ? "-" : path}"
    lines << "  Scope      : #{scope}"                     if scope
    lines << "  Rules      : #{Array(rules).join(',')}"    if rules && !Array(rules).empty?
    lines << "  Exclude    : #{exclude}"                   if exclude && !exclude.to_s.empty?
    lines << "  Duration   : #{format('%.2fs', elapsed)}"  if elapsed
    lines << "  Label      : #{label}"                     if label && !label.to_s.strip.empty?
    lines << "  Reason     : #{reason}"                    if reason

    puts lines.join("\n")
  end
end

World(A11yAssertions)
