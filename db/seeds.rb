require 'time'
require 'date'
require './db/parser'
require './app/models/station'
require './app/models/condition'
require './app/models/city'
require './app/models/subscription_type'
require './app/models/trip'
require 'smarter_csv'

include CSV_parser

parse('./db/csv/station.csv').each do |row|

  city = City.find_or_create_by(name: row[:city])

  Station.create(name:              row[:name],
                 dock_count:        row[:dock_count],
                 installation_date: Date.strptime(row[:installation_date], "%m/%d/%Y"),
                 city_id:           city.id
                 )
end

parse('./db/csv/weather.csv').each do |row|

  if row[:zip_code] == '94107'

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
end

parse('./db/csv/trip.csv').each do |row|

  start_station_name = row[:start_station_name]
  end_station_name = row[:end_station_name]

  if end_station_name.include?("Kearny")
    end_station_name.gsub!("Kearny", "Kearney")
  end

  if start_station_name.include?("Kearny")
    start_station_name.gsub!("Kearny", "Kearney")
  end

  if start_station_name.include?("Broadway at Main")
    start_station_name.gsub!("Broadway at Main", "Stanford in Redwood City")
  end

  if end_station_name.include?("Broadway at Main")
    end_station_name.gsub!("Broadway at Main", "Stanford in Redwood City")
  end

  if start_station_name.include?("San Jose Government Center")
    start_station_name.gsub!("San Jose Government Center", "Santa Clara County Civic Center")
  end

  if end_station_name.include?("San Jose Government Center")
    end_station_name.gsub!("San Jose Government Center", "Santa Clara County Civic Center")
  end

  subscription_type = SubscriptionType.find_or_create_by(name: row[:subscription_type])
  start_station     = Station.find_by(name: start_station_name)
  start_station_id  = start_station.id rescue nil
  end_station       = Station.find_by(name: end_station_name)
  end_station_id    = end_station.id rescue nil
  end_date          = DateTime.strptime(row[:end_date], "%m/%d/%Y %H:%M")
  start_date        = DateTime.strptime(row[:start_date], "%m/%d/%Y %H:%M")
  condition         = Condition.find_by(date: start_date)
  condition_id      = condition.id rescue nil


  Trip.create(duration: row[:duration],
              start_date: start_date,
              end_date: end_date,
              end_station_id: end_station_id,
              bike_id: row[:bike_id],
              zip_code: row[:zip_code],
              station_id: start_station_id,
              condition_id: condition_id,
              subscription_type_id: subscription_type.id
              )
end
