module WaitHelpers
  DEFAULT_WAIT = 5

  def wait_until_visible(type, selector, timeout: DEFAULT_WAIT)
    Selenium::WebDriver::Wait.new(timeout: timeout).until do
      element = @driver.find_element(type, selector)
      return element if element.displayed?
    end
  rescue Selenium::WebDriver::Error::NoSuchElementError, Selenium::WebDriver::Error::TimeoutError => e
    raise "❌ [wait_until_visible] Element not visible: #{type} => #{selector} (#{e.class})"
  end

  def wait_until_clickable(type, selector, timeout: DEFAULT_WAIT)
    Selenium::WebDriver::Wait.new(timeout: timeout).until do
      element = @driver.find_element(type, selector)
      return element if element.displayed? && element.enabled?
    end
  rescue Selenium::WebDriver::Error::NoSuchElementError, Selenium::WebDriver::Error::TimeoutError => e
    raise "❌ [wait_until_clickable] Element not clickable: #{type} => #{selector} (#{e.class})"
  end

  def wait_until_exists(type, selector, timeout: DEFAULT_WAIT)
    Selenium::WebDriver::Wait.new(timeout: timeout).until do
      element = @driver.find_element(type, selector)
      return element if element
    end
  rescue Selenium::WebDriver::Error::NoSuchElementError, Selenium::WebDriver::Error::TimeoutError => e
    raise "❌ [wait_until_exists] Element not found: #{type} => #{selector} (#{e.class})"
  end
end
