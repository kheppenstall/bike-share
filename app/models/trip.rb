require_relative 'next_previous'
require_relative 'trip_dashboard'

class Trip < ActiveRecord::Base
  belongs_to  :condition
  belongs_to  :station
  belongs_to  :subscription_type

  include NextPrevious

  def end_station
    Station.find(end_station_id)
  end

  def start_information
    "Start: #{start_date.inspect}, #{station.name rescue "Station Not Found"}"
  end

  def end_information
    "End: #{end_date.inspect}, #{end_station.name rescue "Station Not Found"}"
  end

  extend TripDashboard

end
