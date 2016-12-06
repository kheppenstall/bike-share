require 'time'
require './db/parser'
require './app/models/station'
require './app/models/condition'
require './app/models/city'
include CSV_parser

stations = parse('./db/csv/station.csv').map do |row|

  city = City.find_or_create_by(name: row[:city])

  Station.create(name:              row[:name],
                 dock_count:        row[:dock_count],
                 installation_date: Date.strptime(row[:installation_date], "%m/%d/%Y"),
                 city_id:           city.id
                 )
end

conditions = parse('./db/csv/weather.csv').map do |row|

  Condition.create(date:               Date.strptime(row[:date], "%m/%d/%Y"),
                   max_temperature:    row[:max_temperature_f],
                   mean_temperature:   row[:mean_temperature_f],
                   min_temperature:    row[:min_temperature_f],
                   mean_humidity:      row[:mean_humidity],
                   mean_visibility:    row[:mean_visibility_miles],
                   mean_wind_speed:    row[:mean_wind_speed_mph],
                   precipitation:      row[:precipitation_inches]
                  )
end

trips = parse('./db/csv/trip.csv').map do |row|

  subscription_type = SubscriptionType.find_or_create_by(name: row[:subscription_type])
  start_station = Station.find_by(name: row[:start_station_name])
  start_station = Station.find_by(name: row[:end_station_name])
  start_date = Date.strptime(row[:start_date], "%m/%d/%Y %H:%M")
  condition = Condition.find_by(date: :start_date)
  condition_id = condition.id rescue nil

  Trip.create(
                  )
end