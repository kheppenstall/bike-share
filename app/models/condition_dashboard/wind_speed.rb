module WindSpeed

  def range(floor)
    [floor..floor + 4]
  end

  def wind_speed_trips(floor)
   conditions = where(mean_wind_speed: range(floor))
   conditions.joins(:trips).group(:date).count("id")
  end

  def average_number_of_rides_from_wind_speed(floor)
    average(wind_speed_trips(floor).values)
  end

  def highest_number_of_rides_from_wind_speed(floor)
    wind_speed_trips(floor).values.max
  end

  def lowest_number_of_rides_from_wind_speed(floor)
    wind_speed_trips(floor).values.min
  end
  
end