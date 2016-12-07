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
    nil
  end


end