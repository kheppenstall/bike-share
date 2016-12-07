require_relative 'station_dashboard'

class Station < ActiveRecord::Base
  belongs_to :city

  has_many  :trips
  has_many  :conditions, through: :trips

  validates :name, presence: true, uniqueness: true
  validates :dock_count, presence: true
  validates :installation_date, presence: true
  validates :city_id, presence: true

  extend StationDashboard

  def rides_started_at_station
    trips.count
  end

  def rides_ended_at_station
    Trip.where(end_station_id: id).count
  end

  def most_frequent_destination
    end_station_ids = trips.group_by {|trip| trip.end_station_id}
    station_id = end_station_ids.keys.max_by {|key| end_station_ids[key]}
    Station.find(station_id).name rescue nil
  end

  def most_frequent_origin
    trips_ended_here = Trip.where(end_station_id: id)
    origin_stations = trips_ended_here.joins(:station).group(:name).count("id")
    origin_stations.keys.max_by {|key| origin_stations[key]}
  end

  def date_with_most_trips
    return nil if trips.count.zero?
    weather = trips.joins(:condition).group(:date).count("id")
    weather.keys.max_by {|key| weather[key]}.inspect
  end




end