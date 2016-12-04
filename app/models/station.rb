require 'time'

class Station < ActiveRecord::Base
  belongs_to :city
  validates :name, presence: true, uniqueness: true
  validates :dock_count, presence: true
  validates :installation_date, presence: true
  validates :city_id, presence: true

  def self.average_bikes_per_station
    return 0 if count.zero?
    average("dock_count").round(1)
  end

  def self.station_with_most_bikes
    stations = all.find_all{|station| station.dock_count == max_bike_count}
    names(stations)
  end

  def self.max_bike_count
    return 0 if count == 0
    maximum(:dock_count)
  end

  def self.put_in_list(name, names, list)
    if name == names.last
      "#{list}#{name}"
    else
      "#{name}, #{list}"
    end
  end

  def self.names(stations)
    names = stations.map {|station| station.name}
    names.reduce("") {|list, name| put_in_list(name, names, list)}
  end

  def self.station_with_fewest_bikes
    stations = all.find_all{|station| station.dock_count == min_bike_count}
    names(stations)
  end

  def self.min_bike_count
    return 0 if Station.count == 0
    minimum(:dock_count)
  end

  def installation_time
    Time.strptime(installation_date,"%m/%d/%Y") rescue nil
  end

  def self.stations_with_valid_date
    all.find_all {|station| station.installation_time}
  end

  def self.newest_station
    station = stations_with_valid_date.max_by {|station| station.installation_time}
    station.name rescue ""
  end

  def self.oldest_station
    station = stations_with_valid_date.min_by {|station| station.installation_time}
    station.name rescue ""
  end
end
