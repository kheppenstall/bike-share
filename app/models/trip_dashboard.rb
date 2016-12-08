module TripDashboard

  def average_duration_of_ride
    return 0 if count.zero?
    (average("duration").round(1) / 60).round(2)
  end

  def longest_ride
    return 0 if count.zero?
    (maximum("duration").round(1) / 60).round(2)
  end

  def shortest_ride
    return 0 if count.zero?
    (minimum("duration").round(1) / 60).round(2)
  end

  def start_station_with_most_rides
    return "" if count.zero?
    station = Station.joins(:trips).group(:name).count("id")
    station.keys.max_by {|key| station[key]}
  end

  def end_station_with_most_rides
    return "" if count.zero?
    trips = Trip.joins(:station).group(:end_station_id).count("id")
    station_id = trips.keys.max_by do |key|
      trips[key]
    end
    Station.find(station_id).name
  end

  def rides_per_month(mon, yea)
    return "0" if count.zero?
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

  def best_bike_count
    bikes = Trip.group(:bike_id).count("id")
    bikes[best_bike]
  end

  def worst_bike
    bikes = Trip.group(:bike_id).count("id")
    bikes.keys.min_by do |key|
      bikes[key]
    end
  end

  def worst_bike_count
    bikes = Trip.group(:bike_id).count("id")
    bikes[worst_bike]
  end

  def sub_type_count
    subs = SubscriptionType.joins(:trips).group(:name).count("id")
    subs.values
  end

  def sub_percent
    total = SubscriptionType.joins(:trips).group(:name).count("id").values.sum
    ((sub_type_count[1].to_f / total.to_f) * 100).round(2)
  end

  def cust_percent
    total = SubscriptionType.joins(:trips).group(:name).count("id").values.sum
    ((sub_type_count[0].to_f / total.to_f) * 100).round(2)
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

  def conditions_on_top_date
    Condition.find_by(date: top_trips_per_date[0]).id rescue 1
  end

  def conditions_on_worst_date
    Condition.find_by(date: lowest_trips_per_date[0]).id rescue 1
  end

end
