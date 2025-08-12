require 'date'

module DateHelpers
  def today
    Date.today
  end

  def tomorrow
    Date.today + 1
  end

  def yesterday
    Date.today - 1
  end

  def days_from_now(n)
    Date.today + n
  end

  def days_ago(n)
    Date.today - n
  end

  def format_date(date, format = "%Y-%m-%d")
    date.strftime(format)
  end
end
