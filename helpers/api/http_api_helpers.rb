# frozen_string_literal: true

require "net/http"
require "uri"

module HttpApiHelpers
  def http_response_for(url, base_url: nil, limit: 5)
    raise "Too many redirects" if limit <= 0

    uri = URI.parse(url)

    # Handle relative URLs
    if uri.host.nil?
      base = URI.parse(base_url || Capybara.app_host || page.current_url)
      uri = URI.join(base.to_s, url)
    end

    host = uri.host
    raise ArgumentError, "URL must include a host (got #{uri})" if host.nil?

    http = Net::HTTP.new(host, uri.port)
    http.use_ssl = uri.scheme == "https"
    http.open_timeout = 5
    http.read_timeout = 5

    # The below injects some header content and makes the http calls seem more realistic to the third party servers.
    # This is important as some of them were incorrectly redirecting us as a result and giving false results.
    req = Net::HTTP::Get.new(uri)
    req["User-Agent"] =
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) " \
        "AppleWebKit/537.36 (KHTML, like Gecko) " \
        "Chrome/144.0.0.0 Safari/537.36"
    req["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
    req["Accept-Language"] = "en-GB,en;q=0.9"
    req["Connection"] = "keep-alive"

    response = http.request(req)

    # Follow redirects
    if response.is_a?(Net::HTTPRedirection) && response["location"]
      return http_response_for(
        response["location"],
        base_url: base_url,
        limit: limit - 1
      )
    end

    response
  end

  def validate_http_response_and_content(url, expected_http_status_code, expected_content_or_html)
    response = http_response_for(url)
    expect(response.code.to_i).to eq(expected_http_status_code.to_i)
    expect(response.body).to include(expected_content_or_html)
  end
end
