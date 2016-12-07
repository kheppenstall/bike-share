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
    trips_ended_here = Trip.where(end_station_id: self.id)
    end_stations = trips_ended_here.joins(:station).group(:name).count("id")
    end_stations.keys.max_by {|key| end_stations[key]}
  end

  def most_frequent_origin
    origin_stations = trips.joins(:station).group(:name).count("id")
    origin_stations.keys.max_by {|key| end_stations[key]}

  end


end