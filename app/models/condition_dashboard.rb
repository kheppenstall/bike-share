require './app/models/condition_dashboard/precipitation'
require './app/models/condition_dashboard/visibility'
require './app/models/condition_dashboard/wind_speed'
require './app/models/condition_dashboard/temperature'

module ConditionDashboard

  include Precipitation 
  include Visibility
  include WindSpeed
  include Temperature
  
  def trips_from_conditions(conditions)
    condition_ids = conditions.map {|condition| condition.id}
    Trip.where(condition_ids.include?(:condition_id))
  end
  
  def average_rides(conditions)
    return 0 if conditions.count.zero?
    trips = trips_from_conditions(conditions)
    (trips.count / conditions.count.to_f).round(1)
  end

  def highest_number_of_rides(conditions)
    return 0 if conditions.count.zero?
    max_condition = conditions.max_by {|condition| condition.trips.count}
    max_condition.trips.count
  end

  def lowest_number_of_rides(conditions)
    return 0 if conditions.count.zero?
    min_condition = conditions.min_by {|condition| condition.trips.count}
    min_condition.trips.count
  end

  #### temperature
  
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

  ####precipitation

  def conditions_from_precip(precip_ceil)
    ceil = precip_ceil.to_f
    return all.where(precipitation: 0) if ceil == 0
    all.find_all do |condition|
      condition.precipitation <= ceil && condition.precipitation > ceil - 0.5
    end
  end

  def average_number_of_rides_from_precip(precip_ceil)
    conditions = conditions_from_precip(precip_ceil)
    average_rides(conditions)
  end

  def highest_number_of_rides_from_precip(precip_ceil)
    conditions = conditions_from_precip(precip_ceil)
    highest_number_of_rides(conditions)
  end

  def lowest_number_of_rides_from_precip(precip_ceil)
    conditions = conditions_from_precip(precip_ceil)
    lowest_number_of_rides(conditions)
  end


  ####wind speeds

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

# Breakout of average number of rides, highest number of rides, and lowest number of rides on days with mean visibility in miles in four mile increments.