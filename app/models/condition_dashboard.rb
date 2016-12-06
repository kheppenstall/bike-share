require_relative 'names'

module ConditionDashboard
  
  def range(temp_floor)
    (temp_floor..temp_floor + 9)
  end

  def conditions_from_temperature(temp_floor)
    Condition.all.find_all{|condition| range(temp_floor).include?(condition.max_temperature)}
  end

  def trips_from_conditions(conditions)
    condition_ids = conditions.map {|condition| condition.id}
    Trip.where(condition_ids.include?(:condition_id))
  end
  
  def average_number_of_rides_from_temp(temp_floor, date)
    conditions = conditions_from_temperature(temp_floor)
    return 0 if conditions.count.zero?

    trips = trips_from_conditions(conditions)
    (trips.count / conditions.count.to_f).round(1)
  end

  def highest_number_of_rides_from_temp(temp_floor, date)
    conditions = conditions_from_temperature(temp_floor)
    max_condition = conditions.max_by {|condition| condition.trips.count}
    max_condition.trips.count
  end

end


# Breakout of average number of rides, highest number of rides, 
# and lowest number of rides on days with a high temperature 
# in 10 degree chunks (e.g. average number of rides on days with 
# high temps between fifty and sixty degrees)

# Breakout of average number of rides, highest number of rides, and lowest number of rides on days with precipitation in half-inch increments.
# Breakout of average number of rides, highest number of rides, and lowest number of rides on days with mean wind speeds in four mile increments.
# Breakout of average number of rides, highest number of rides, and lowest number of rides on days with mean visibility in miles in four mile increments.