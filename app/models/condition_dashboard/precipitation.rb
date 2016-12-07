module Precipitation

 def range(floor)
    [floor..floor + 0.5]
  end

  def precipitation_trips(floor)
   conditions = where(precipitation: range(floor))
   conditions.joins(:trips).group(:date).count("id")
  end

  def average_number_of_rides_from_precipitation(floor)
    puts precipitation_trips(floor).inspect
    average(precipitation_trips(floor).values)
  end

  def highest_number_of_rides_from_precipitation(floor)
    precipitation_trips(floor).values.max
  end

  def lowest_number_of_rides_from_precipitation(floor)
    precipitation_trips(floor).values.min
  end

end