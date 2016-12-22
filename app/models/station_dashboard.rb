require_relative 'names'

module StationDashboard

  include Names

  def average_bikes_per_station
    return 0 if count.zero?
    average("dock_count").round(1)
  end

  def station_with_most_bikes
    stations = where(dock_count: max_bike_count)
    names(stations) rescue ""
  end

  def max_bike_count
    return 0 if count.zero?
    maximum(:dock_count)
  end

  def station_with_fewest_bikes
    stations = where(dock_count: min_bike_count)
    names(stations) rescue ""
  end

  def min_bike_count
    return 0 if count.zero?
    minimum(:dock_count)
  end

  def newest_station
    date = maximum(:installation_date)
    where(installation_date: date).first.name rescue ""
  end

  def oldest_station
    date = minimum(:installation_date)
    where(installation_date: date).first.name rescue ""
  end
end