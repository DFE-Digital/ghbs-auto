require_relative '../components/fabs_search_page_comps'

class FabsSearchPage
  def initialize(driver, secrets)
    @driver = driver
    @secrets = secrets
    @search_page_comps = FabsSearchPageComps.new(@driver)
  end

  def search_result_for_laptop_check
    @search_page_comps.search_result_title("Everything ICT")
    @search_page_comps.search_result_title("CCS purchasing platform catalogue")
    @search_page_comps.search_result_title("Microsoft Shape The Future")
  end

end
