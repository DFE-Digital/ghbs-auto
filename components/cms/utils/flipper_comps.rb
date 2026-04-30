# frozen_string_literal: true

class FlipperComps
  include Capybara::DSL

  def text_page_heading
    find(:xpath, "//h4")
  end

  def text_flag_name_only(flag_name)
    find(:xpath, "//a[contains(.,'#{flag_name}')]/div/div[2]/div[1]")
  end

  def xpath_flag_name_and_state(flag_name)
    "//a[contains(.,'#{flag_name}')]/div/div[2]/div[2]"
  end

  def text_flag_name_and_state(flag_name)
    find(:xpath, xpath_flag_name_and_state(flag_name))
  end
end
