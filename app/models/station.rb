require 'time'

class Station < ActiveRecord::Base
  belongs_to :city
  validates :name, presence: true, uniqueness: true
  validates :dock_count, presence: true
  validates :installation_date, presence: true
  validates :city_id, presence: true

  def self.average_bikes_per_station
    return 0 if count == 0
    average("dock_count").round(1)
  end

  def self.station_with_most_bikes
    where(dock_count: max_bike_count)
  end

  def self.max_bike_count
    return 0 if count == 0
    maximum(:dock_count)
  end

  def self.station_with_fewest_bikes
    where(dock_count: min_bike_count)
  end

  def self.min_bike_count
    return 0 if Station.count == 0
    minimum(:dock_count)
  end

  def installation_time
    time = Time.strptime(installation_date,"%m/%d/%Y") rescue nil
  end

  def self.stations_with_date
    all.find_all {|station| station.installation_time}
  end

  def self.newest_station
    stations_with_date.min_by {|station| station.installation_time}
  end

  def self.oldest_station
    stations_with_date.max_by {|station| station.installation_time}
  end
end