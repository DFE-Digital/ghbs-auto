# frozen_string_literal: true

require "pages/fabs/fabs_base_page"

class FabsSearchPageMethods < FabsBasePage
  def confirm_returned_buying_options
    expect(page).to have_link("Everything ICT")
    expect(page).to have_link("Technology products & associated services 2")
  end
end
