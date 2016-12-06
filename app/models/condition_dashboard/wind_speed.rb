module WindSpeed

  def conditions_from_wind_speed(wind_floor)
    all.find_all do |condition|
      speed = condition.mean_wind_speed
      speed >= wind_floor && speed < wind_floor + 4
    end
  end

  def average_number_of_rides_from_wind_speed(wind_floor)
    conditions = conditions_from_wind_speed(wind_floor)
    average_rides(conditions)
  end

  def highest_number_of_rides_from_wind_speed(wind_floor)
    conditions = conditions_from_wind_speed(wind_floor)
    highest_number_of_rides(conditions)
  end

  def lowest_number_of_rides_from_wind_speed(wind_floor)
    conditions = conditions_from_wind_speed(wind_floor)
    lowest_number_of_rides(conditions)
  end
  
end