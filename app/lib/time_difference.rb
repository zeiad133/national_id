class TimeDifference
  def initialize(start_time, end_time)
    year_difference = start_time.year - end_time.year
    month_difference = start_time.month - end_time.month
    days_difference = start_time.day - end_time.day
    @time_diff =  {years: year_difference, months: month_difference, days: days_difference}
  end

  def min_age_exceeded?
    days_difference = time_diff[:days]
    month_difference = time_diff[:months]
    years_difference = time_diff[:years]
    return true if years_difference > 16
    return false if years_difference < 16

    return true if month_difference > 0
    return false if month_difference < 0

    days_difference >= 0
  end

  private
  attr_reader :time_diff
end