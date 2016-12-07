require_relative 'next_previous'
require_relative 'trip_dashboard'
require 'time'

class Trip < ActiveRecord::Base
  belongs_to  :condition
  belongs_to  :station
  belongs_to  :subscription_type

  include NextPrevious
  extend TripDashboard

  def end_station
    Station.find(end_station_id)
  end

  def start_information
    "Start: #{start_date.inspect}, #{station.name rescue "Station Not Found"}"
  end

  def end_information
    "End: #{end_date.inspect}, #{end_station.name rescue "Station Not Found"}"
  end

  def self.make_trip(trip_information)
    start_date        = Time.parse(trip_information["start_date"])
    end_date          = Time.parse(trip_information["end_date"])
    bike_id           = trip_information["bike_id"]
    zipcode           = trip_information["zip_code"]
    start_station     = Station.find_by(name: trip_information["start_station_name"])
    end_station       = Station.find_by(name: trip_information["end_station_name"])
    duration          = (end_date - start_date).to_i
    condition         = Condition.find_by(date: "#{start_date.to_date}")
    condition_id      = condition.id rescue nil
    subscription_type = SubscriptionType.find_by(name: trip_information['subscription_type'])
    trip              = Trip.create(duration: duration, start_date: start_date,
                        end_date: end_date, station_id: start_station.id, end_station_id: end_station.id,
                        bike_id: bike_id, zip_code: zipcode,
                        condition_id: condition_id, subscription_type_id: subscription_type.id)
  end

  def self.update_trip(trip_information, trip)
    start_date        = Time.parse(trip_information["start_date"])
    end_date          = Time.parse(trip_information["end_date"])
    duration          = (end_date - start_date).to_i
    start_station     = Station.find_by(name: trip_information['start_station_name']).id
    end_station       = Station.find_by(name: trip_information["end_station_name"]).id
    bike_id           = trip_information['bike_id']
    zip_code          = trip_information['zip_code']
    condition         = Condition.find_by(date: "#{start_date.to_date}")
    condition_id      = condition.id rescue nil
    subscription_type = SubscriptionType.find_by(name: trip_information['subscription_type'])
    trip.update(duration: duration,
                start_date: start_date, end_date: end_date,
                end_station_id: end_station, bike_id: bike_id,
                zip_code: zip_code, station_id: start_station, condition_id: condition_id,
                subscription_type_id: subscription_type.id)
  end


end
