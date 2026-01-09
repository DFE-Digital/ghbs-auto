# frozen_string_literal: true

require "pages/fabs/fabs_base_page"
require "helpers/url_nav_helpers"
require "helpers/validation_helpers"
require "helpers/api/contentful_api_helpers"

class ContentfulApiMethods < FabsBasePage
  include UrlHelpers
  include ValidationHelpers

  def confirm_solution_has_been_added_to_the_api
    contentful_api = ContentfulApiHelpers.new(
      base_url: SECRETS["contentful_test_env_api"]
    )

    title = framework_state.title

    # Fetch the solution by title
    solution = contentful_api.wait_for_solution_by_title!(title, timeout: 5, interval: 0.25)

    # Validate fields on the returned record against what we added
    expect(solution["title"]).to eq(framework_state.title)
    expect(solution["descr"]).to eq(framework_state.description)
    expect(contentful_api.dig!(solution, "provider", "title")).to eq(framework_state.provider_name)
    expect(solution["provider_reference"]).to eq(framework_state.provider_ref)
    expect(solution["url"]).to eq(framework_state.url)
    expect(solution["ref"]).to eq(framework_state.slug)
    expect(contentful_api.dig!(solution, "provider", "initials")).to eq(framework_state.provider_initials)

    # Store unique solution contentful id for validation within the Framework Register
    framework_state.contentful_id = solution["id"]
  end
end
