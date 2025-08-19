require_relative './fabs_base_page'

class FabsSearchMethods < FabsBasePage

  def confirm_returned_buying_options
    expect(page).to have_link("Everything ICT")
    expect(page).to have_link("CCS purchasing platform catalogue")
    expect(page).to have_link("Microsoft Shape The Future")
  end

end

