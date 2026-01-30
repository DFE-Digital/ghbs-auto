# frozen_string_literal: true

require "net/http"
require "uri"

module HttpApiHelpers
  def http_response_for(url, base_url: nil)
    uri = URI.parse(url)

    # If it's relative (no host), resolve against a base
    if uri.host.nil?
      base = URI.parse(base_url || Capybara.app_host || page.current_url)
      uri = URI.join(base.to_s, url)
    end

    host = uri.host
    raise ArgumentError, "URL must include a host (got: #{url.inspect})" if host.nil?

    Net::HTTP.start(
      host,
      uri.port,
      use_ssl: uri.scheme == "https",
      open_timeout: 5,
      read_timeout: 5
    ) do |http|
      http.request(Net::HTTP::Get.new(uri))
    end
  end

  def validate_http_response_and_content(url, expected_http_status_code, expected_content_or_html)
    response = http_response_for(url)
    expect(response.code.to_i).to eq(expected_http_status_code.to_i)
    expect(response.body).to include(expected_content_or_html)
  end
end
