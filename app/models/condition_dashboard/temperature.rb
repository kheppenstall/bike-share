module Temperature

  def temp_range(temp_floor)
    [temp_floor..temp_floor + 9]
  end

  def condition_trips(temp_floor)
    conditions = where(max_temperature: temp_range(temp_floor))
    conditions.joins(:trips).group(:date).count("id")
  end

  def average_number_of_rides_from_temp(temp_floor)
    average(condition_trips(temp_floor).values)
  end

  def highest_number_of_rides_from_temp(temp_floor)
    condition_trips(temp_floor).values.max
  end

  def lowest_number_of_rides_from_temp(temp_floor)
    condition_trips(temp_floor).values.min
  end
end