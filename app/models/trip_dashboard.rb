require 'pry'

module TripDashboard

  def average_duration_of_ride
    return 0 if count.zero?
    average("duration").round(1)
  end

  def longest_ride
    return 0 if count.zero?
    maximum("duration").round(1)
  end

  def shortest_ride
    return 0 if count.zero?
    minimum("duration").round(1)
  end

  def start_station_with_most_rides
    return 0 if count.zero?
    Station.all.max_by do |station|
      station.trips.count
    end
  end

  def end_station_with_most_rides
    return "" if count.zero?
    ids = Trip.all.group_by {|trip| trip.end_station_id}
    id  = ids.keys.max_by {|key| ids[key]}
    Station.find(id)
  end

  def rides_per_month
    return "none" if count.zero?

    #Month by Month breakdown of number of rides with subtotals for each year
  end

  def find_bike
    Trip.all.group_by {|trip|trip.bike_id}
  end

  def best_bike
    find_bike.keys.max_by do |key|
      find_bike[key].count
    end
  end

  def best_bike_trip_count
    Trip.all.find_all do |trip|
      trip.bike_id == best_bike
    end.count
  end

  def worst_bike
    find_bike.keys.min_by do |key|
      find_bike[key].count
    end
  end

  def worst_bike_trip_count
    Trip.all.find_all do |trip|
      trip.bike_id == worst_bike
    end.count
  end

  def sub_type_count
    SubscriptionType.all.group_by {|sub| sub.name}
    #User subscription type breakout with both count and percentage.
  end

  def customers
    sub_type_count["Customer"].count
  end

  def customer_percentage
    (customers.to_f / total).round(2) * 100
  end

  def subscribers
    sub_type_count["Subscriber"].count
  end

  def subscriber_percentage
    (subscribers.to_f / total).round(2) * 100
  end

  def total_subs
    customers.to_f + subscribers.to_f
  end

  def max_trips_per_date
    #Single date with the highest number of trips with a count of those trips
  end

  def min_trips_per_Date
    #Single date with the lowest number of trips with a count of those trips
  end

end
