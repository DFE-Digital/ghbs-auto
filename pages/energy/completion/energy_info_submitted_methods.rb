# frozen_string_literal: true

require "pages/energy/energy_base_page"
require "components/energy/completion/energy_info_submitted_comps"
class EnergyInfoSubmittedMethods < EnergyBasePage

  def validate_information_date_is_today
    # validate the page has loaded
    expect(page).to have_current_path(%r{/information-submitted}, url: true, wait: 10)
    expect(energy_info_submitted_comps.text_page_heading.text).to include("Information submitted on")

    # Read the text from the element
    info_string = energy_info_submitted_comps.text_page_heading.text.strip

    # Expected string for today's date
    today_formatted = Date.today.strftime("%-d %B %Y")
    expected_string = "Information submitted on #{today_formatted}"

    # Validate exact match
    unless info_string == expected_string
      raise "AUTO ERROR: Expected '#{expected_string}' but got '#{info_string}'"
    end

    puts "[INFO] Validated date successfully: #{info_string}"

    # Add to case state
    case_state.case_number = energy_info_submitted_comps.text_case_number.text
  end

end
