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
end