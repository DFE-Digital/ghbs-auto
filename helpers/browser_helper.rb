module BrowserHelper

  attr_accessor :driver

  def visit(url)
    @driver.navigate.to(url)
  end

  def find(selector, by: :css)
    @driver.find_element(by, selector)
  end

  def click(selector, by: :css)
    find(selector, by: by).click
  end

  def fill(selector, value, by: :css)
    element = find(selector, by: by)
    element.clear
    element.send_keys(value)
  end

  def text_of(selector, by: :css)
    find(selector, by: by).text
  end

  def resize_current_browser(width, height)
    @driver.manage.window.resize_to(width, height)
  end

end
