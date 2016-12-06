require_relative 'next_previous'

class Trip < ActiveRecord::Base
  belongs_to  :condition
  belongs_to  :station
  belongs_to  :subscription_type

  validates   :duration,             presence: true
  validates   :start_date,           presence: true
  validates   :bike_id,              presence: true
  validates   :zip_code,             presence: true
  validates   :station_id,           presence: true
  validates   :subscription_type_id, presence: true

  include NextPrevious

  def end_station
    Station.find(end_station_id)
  end

  def start_information
    "Start: #{start_date}, #{station.name rescue "Station Not Found"}"
  end

  def end_information
    "End: #{end_date}, #{end_station.name rescue "Station Not Found"}"
  end

end
