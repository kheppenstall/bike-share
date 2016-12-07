module Visibility

  def range(floor)
    [floor..floor + 4]
  end

  def visibility_trips(floor)
   conditions = where(mean_visibility: range(floor))
   conditions.joins(:trips).group(:date).count("id")
  end

  def average_number_of_rides_from_visibility(floor)
    average(visibility_trips(floor).values)
  end

  def highest_number_of_rides_from_visibility(floor)
    visibility_trips(floor).values.max
  end

  def lowest_number_of_rides_from_visibility(floor)
    visibility_trips(floor).values.min
  end
end