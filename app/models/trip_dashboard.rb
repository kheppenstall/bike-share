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
    return "" if count.zero?
    station = Station.joins(:trips).group(:name).count("id").max
    station[0]
  end

  def end_station_with_most_rides
    return "" if count.zero?
    station = Station.joins(:trips).group(:name).count("id").min
    station[0]
  end

  def rides_per_month(mon, yea)
    return "none" if count.zero?
    month_trips = Trip.where('extract(month FROM start_date) = ?',mon)
    year_trips = month_trips.where('extract(year FROM start_date)= ?', yea)
    year_trips.count
  end

  def best_bike
    bikes = Trip.group(:bike_id).count("id")
    bikes.keys.max_by do |key|
      bikes[key]
    end
  end

  def worst_bike
    bikes = Trip.group(:bike_id).count("id")
    bikes.keys.min_by do |key|
      bikes[key]
    end
  end

  def worst_bike_trip_count
    Trip.all.find_all do |trip|
      trip.bike_id == worst_bike
    end.count
  end

  def sub_type_count
    SubscriptionType.all.group_by {|sub| sub.name}
  end

  def customers
    sub_type_count["Customer"].count
  end

  def customer_percentage
    (customers.to_f / total_subs).round(2) * 100
  end

  def subscribers
    sub_type_count["Subscriber"].count
  end

  def subscriber_percentage
    (subscribers.to_f / total_subs).round(2) * 100
  end

  def total_subs
    customers.to_f + subscribers.to_f
  end

  def top_trips_per_date
    trips_by_condition = Condition.joins(:trips).group(:date).count("id")
    max_trips = trips_by_condition.values.max
    date = trips_by_condition.key(max_trips)
    [date, max_trips]
  end

  def lowest_trips_per_date
    trips_by_condition = Condition.joins(:trips).group(:date).count("id")
    max_trips = trips_by_condition.values.min
    date = trips_by_condition.key(max_trips)
    [date, max_trips]
  end

end
