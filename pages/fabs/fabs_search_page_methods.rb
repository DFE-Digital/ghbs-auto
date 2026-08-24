# frozen_string_literal: true

require "pages/fabs/fabs_base_page"

class FabsSearchPageMethods < FabsBasePage
  def confirm_returned_buying_options
    expect(page).to have_link("GCA purchasing platform catalogue")
    expect(page).to have_link("IT, hardware, ITAD & associated services")
  end
end
