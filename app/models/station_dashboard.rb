module StationDashboard

  def average_bikes_per_station
    return 0 if count.zero?
    average("dock_count").round(1)
  end

  def station_with_most_bikes
    stations = all.find_all{|station| station.dock_count == max_bike_count}
    names(stations)
  end

  def max_bike_count
    return 0 if count == 0
    maximum(:dock_count)
  end

  def put_in_list(name, names, list)
    if name == names.last
      "#{list}#{name}"
    else
      "#{name}, #{list}"
    end
  end

  def names(stations)
    names = stations.map {|station| station.name}
    names.reduce("") {|list, name| put_in_list(name, names, list)}
  end

  def station_with_fewest_bikes
    stations = all.find_all{|station| station.dock_count == min_bike_count}
    names(stations)
  end

  def min_bike_count
    return 0 if count == 0
    minimum(:dock_count)
  end

  def newest_station
    station = all.max_by {|station| station.installation_date}
    station.name rescue ""
  end

  def oldest_station
    station = all.min_by {|station| station.installation_date}
    station.name rescue ""
  end
end