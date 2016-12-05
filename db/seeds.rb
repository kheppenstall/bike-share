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

Condition.create(date: Date.strptime(row[:date], "%m/%d/%Y"),
                 max_temperature: row[:max_temperature],
                 mean_temperature: row[:mean_temperature],
                 min_temperature: row[:min_temperature],
                 mean_humidity: row[:mean_humidity],
                 mean_visibility: row[:mean_visibility],
                 mean_wind_speed: row[:mean_wind_speed],
                 precipitation: row[:precipitation]
                )
end