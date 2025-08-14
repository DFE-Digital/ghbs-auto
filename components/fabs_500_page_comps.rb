class Fabs500PageComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

end