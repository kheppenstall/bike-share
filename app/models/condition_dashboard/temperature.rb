module Temperature

  def temp_range(temp_floor)
    (temp_floor..temp_floor + 9)
  end

  def conditions_from_temperature(temp_floor)
    all.find_all{|condition| temp_range(temp_floor).include?(condition.max_temperature)}
  end

  def average_number_of_rides_from_temp(temp_floor)
    conditions = conditions_from_temperature(temp_floor)
    average_rides(conditions)
  end

  def highest_number_of_rides_from_temp(temp_floor)
    conditions = conditions_from_temperature(temp_floor)
    highest_number_of_rides(conditions)
  end

  def lowest_number_of_rides_from_temp(temp_floor)
    conditions = conditions_from_temperature(temp_floor)
    lowest_number_of_rides(conditions)
  end

end