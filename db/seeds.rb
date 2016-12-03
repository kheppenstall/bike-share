require './db/parser'
require './app/models/station'
require './app/models/city'
include CSV_parser

stations = parse('./db/csv/station.csv').map do |row|

  city = City.find_or_create_by(name: row[:city])

  Station.create(name:              row[:name],
                 dock_count:        row[:dock_count],
                 installation_date: row[:installation_date],
                 city_id:           city.id
                 )
end