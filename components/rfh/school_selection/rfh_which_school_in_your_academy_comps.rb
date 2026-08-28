# frozen_string_literal: true

class RfhWhichSchoolInYourAcademyComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h1")
  end

  def link_back
    find(:xpath, "//a[text()='Back']")
  end

  def text_school_selection(school_name)
    find(:xpath, "//label[text()='#{school_name}']")
  end

  def text_first_school_from_the_list
    find(:xpath, "//table[@aria-label='Available schools']/tbody[1]//tr[1]//label")
  end

  def text_number_of_selected_schools
    find(:xpath, "//div[@data-controller = 'school-picker']/p")
  end

  def button_continue
    find(:xpath, "//input[@value='Continue']")
  end
end
