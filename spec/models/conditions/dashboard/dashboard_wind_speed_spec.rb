# require './spec/spec_helper'

# describe 'Condition dashboard' do
#   describe '.average_number_of_rides_from_wind_speed' do
#     it 'calculates average number of trips given floor of wind speed chunk' do
#       condition = Condition.create(date: "01/01/2015", mean_wind_speed: 0)
#       condition.trips.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: 0, bike_id: 0, zip_code: 0, station_id: 0, subscription_type_id: 0)
#       condition.trips.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: 0, bike_id: 0, zip_code: 0, station_id: 0, subscription_type_id: 0)

#       expect(Condition.average_number_of_rides_from_wind_speed(0)).to eq(2)
#     end

#     it 'calculates average number of trips given floor of wind speed chunk greater than zero' do
#       condition = Condition.create(date: "01/01/2015", mean_wind_speed: 5)
#       condition.trips.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: 0, bike_id: 0, zip_code: 0, station_id: 0, subscription_type_id: 0)

#       expect(Condition.average_number_of_rides_from_wind_speed(4)).to eq(1)
#     end

#     it 'calculates average number of trips with multiple conditions' do
#       condition = Condition.create(date: "01/01/2015", mean_wind_speed: 9)
#       Condition.create(date: "01/02/2015", mean_wind_speed: 10)

#       condition.trips.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: 0, bike_id: 0, zip_code: 0, station_id: 0, subscription_type_id: 0)

#       expect(Condition.average_number_of_rides_from_wind_speed(4)).to eq(0)
#       expect(Condition.average_number_of_rides_from_wind_speed(8)).to eq(0.5)
#     end

#     it 'assigns average numer of rides to zero when there are no trips in wind_speed range' do

#       expect(Condition.average_number_of_rides_from_wind_speed(0)).to eq(0)
#     end
#   end

#    describe '.highest_number_of_rides_from_wind_speed' do
#     it 'calculates highest number of trips given floor of wind speed chunk' do
#       condition = Condition.create(date: "01/01/2015", mean_wind_speed: 0)
#       condition.trips.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: 0, bike_id: 0, zip_code: 0, station_id: 0, subscription_type_id: 0)
#       condition.trips.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: 0, bike_id: 0, zip_code: 0, station_id: 0, subscription_type_id: 0)

#       expect(Condition.highest_number_of_rides_from_wind_speed(0)).to eq(2)
#     end

#     it 'calculates highest number of trips given floor of wind speed chunk greater than zero' do
#       condition = Condition.create(date: "01/01/2015", mean_wind_speed: 5)
#       condition.trips.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: 0, bike_id: 0, zip_code: 0, station_id: 0, subscription_type_id: 0)

#       expect(Condition.highest_number_of_rides_from_wind_speed(4)).to eq(1)
#     end

#     it 'calculates highest number of trips with multiple conditions' do
#       condition = Condition.create(date: "01/01/2015", mean_wind_speed: 9)
#       Condition.create(date: "01/02/2015", mean_wind_speed: 10)

#       condition.trips.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: 0, bike_id: 0, zip_code: 0, station_id: 0, subscription_type_id: 0)

#       expect(Condition.highest_number_of_rides_from_wind_speed(4)).to eq(0)
#       expect(Condition.highest_number_of_rides_from_wind_speed(8)).to eq(1)
#     end

#     it 'assigns highest numer of rides to zero when there are no trips in wind_speed range' do

#       expect(Condition.highest_number_of_rides_from_wind_speed(0)).to eq(0)
#     end
#   end

#    describe '.lowest_number_of_rides_from_wind_speed' do
#     it 'calculates lowest number of trips given floor of wind speed chunk' do
#       condition = Condition.create(date: "01/01/2015", mean_wind_speed: 0)
#       condition.trips.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: 0, bike_id: 0, zip_code: 0, station_id: 0, subscription_type_id: 0)
#       condition.trips.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: 0, bike_id: 0, zip_code: 0, station_id: 0, subscription_type_id: 0)

#       expect(Condition.lowest_number_of_rides_from_wind_speed(0)).to eq(2)
#     end

#     it 'calculates lowest number of trips given floor of wind speed chunk greater than zero' do
#       condition = Condition.create(date: "01/01/2015", mean_wind_speed: 5)
#       condition.trips.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: 0, bike_id: 0, zip_code: 0, station_id: 0, subscription_type_id: 0)

#       expect(Condition.lowest_number_of_rides_from_wind_speed(4)).to eq(1)
#     end

#     it 'calculates lowest number of trips with multiple conditions' do
#       condition = Condition.create(date: "01/01/2015", mean_wind_speed: 9)
#       Condition.create(date: "01/02/2015", mean_wind_speed: 10)

#       condition.trips.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: 0, bike_id: 0, zip_code: 0, station_id: 0, subscription_type_id: 0)

#       expect(Condition.lowest_number_of_rides_from_wind_speed(4)).to eq(0)
#       expect(Condition.lowest_number_of_rides_from_wind_speed(8)).to eq(0)
#     end

#     it 'assigns lowest numer of rides to zero when there are no trips in wind_speed range' do

#       expect(Condition.lowest_number_of_rides_from_wind_speed(0)).to eq(0)
#     end
#   end
# end
