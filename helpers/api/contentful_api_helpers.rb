# frozen_string_literal: true

require "faraday"
require "json"

class ContentfulApiHelpers
  DEFAULT_OPEN_TIMEOUT = 5
  DEFAULT_READ_TIMEOUT = 5
  DEFAULT_WAIT_TIMEOUT = 5.0
  DEFAULT_INTERVAL     = 0.25

  def initialize(base_url:)
    @conn = Faraday.new(url: base_url) do |f|
      f.headers["Accept"] = "application/json"
      f.options.open_timeout = DEFAULT_OPEN_TIMEOUT
      f.options.timeout      = DEFAULT_READ_TIMEOUT
      f.adapter Faraday.default_adapter
    end
  end

  # Fetch all solutions from the API
  def solutions
    response = @conn.get("/bfys/solutions.json")

    unless response.status.between?(200, 299)
      raise "Contentful API returned HTTP #{response.status}: #{response.body}"
    end

    JSON.parse(response.body)
  end

  # Find a solution by title immediately (no waiting)
  def find_solution_by_title!(title)
    solution = find_solution_by_title(title)
    raise "Solution not found with title: #{title}" unless solution

    solution
  end

  # Find a solution by title, but wait/retry until timeout expires.
  def wait_for_solution_by_title!(title, timeout: DEFAULT_WAIT_TIMEOUT, interval: DEFAULT_INTERVAL)
    deadline = current_time + timeout
    last_error = nil

    while current_time < deadline
      begin
        solution = find_solution_by_title(title)
        return solution if solution
      rescue Faraday::TimeoutError, Faraday::ConnectionFailed => e
        # Treat transient network problems as retryable
        last_error = e
      rescue JSON::ParserError => e
        # Rare, but can happen if API briefly returns non-JSON / incomplete response
        last_error = e
      rescue StandardError => e
        last_error = e
      end

      sleep(interval)
    end

    # One final attempt to give a better error message if it is now present
    solution = find_solution_by_title(title)
    return solution if solution

    msg = "Solution not found with title: #{title} after #{timeout}s"
    msg += " (last error: #{last_error.class}: #{last_error.message})" if last_error
    raise msg
  end

  def dig!(hash, *path)
    value = hash.dig(*path)
    raise "Missing JSON path: #{path.join(' > ')}" if value.nil?

    value
  end

private

  # Non-bang version: returns nil if not found
  def find_solution_by_title(title)
    data = solutions

    records =
      if data.is_a?(Hash) && data.key?("data")
        data["data"]
      else
        data
      end

    return nil unless records.is_a?(Array)

    records.find { |record| record.is_a?(Hash) && record["title"] == title }
  end

  def current_time
    Process.clock_gettime(Process::CLOCK_MONOTONIC)
  end
end
