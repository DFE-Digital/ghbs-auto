# frozen_string_literal: true

Given("we open and validate the start of the energy onboarding flow") do
  energy_start_page_methods.open_energy_start_page
  energy_start_page_methods.validate_start_page_loaded
end
