# require './spec/spec_helper'

# describe 'Condition dashboard' do
#   describe '.average_number_of_rides_from_temp' do
#     it 'calculates average number of trips given floor of ten degree chunk' do
#       Condition.create(date: "01/02/2015", max_temperature: 55)
#       condition = Condition.create(date: "01/01/2015", max_temperature: 55)
#       trip = condition.trips.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: 0, bike_id: 0, zip_code: 0, station_id: 0, subscription_type_id: 0)

#       expect(Condition.average_number_of_rides_from_temp(50)).to eq(0.5)
#     end

#     it 'assigns average numer of rides to zero when there are no trips in range' do
      
#       expect(Condition.average_number_of_rides_from_temp(0)).to eq(0)
#     end

#     it 'calculates average number of trips only including those in range' do
#       Condition.create(date: "01/02/2015", max_temperature: 65)
#       condition = Condition.create(date: "01/01/2015", max_temperature: 55)
#       trip = condition.trips.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: 0, bike_id: 0, zip_code: 0, station_id: 0, subscription_type_id: 0)

#       expect(Condition.average_number_of_rides_from_temp(50)).to eq(1)
#     end
#   end

#   describe '.highest_number_of_rides_from_temp' do
#     it 'finds the highest number of rides on any day within the temperature range where is only one trip' do
#       condition = Condition.create(date: "01/01/2015", max_temperature: 55)
#       trip = condition.trips.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: 0, bike_id: 0, zip_code: 0, station_id: 0, subscription_type_id: 0)

#       expect(Condition.highest_number_of_rides_from_temp(50)).to eq(1)
#     end

#     it 'finds the highest number of rides on any day within the temperature range with two trips' do
#       condition = Condition.create(date: "01/01/2015", max_temperature: 55)
#       trip = condition.trips.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: 0, bike_id: 0, zip_code: 0, station_id: 0, subscription_type_id: 0)
#       trip = condition.trips.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: 0, bike_id: 0, zip_code: 0, station_id: 0, subscription_type_id: 0)

#       expect(Condition.highest_number_of_rides_from_temp(50)).to eq(2)
#     end

#     it 'finds the highest number of rides on any day within the temperature range with two conditions' do
#       condition_one = Condition.create(date: "01/01/2015", max_temperature: 55)
#       condition_two = Condition.create(date: "01/02/2015", max_temperature: 55)
#       trip = condition_one.trips.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: 0, bike_id: 0, zip_code: 0, station_id: 0, subscription_type_id: 0)
#       trip = condition_two.trips.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: 0, bike_id: 0, zip_code: 0, station_id: 0, subscription_type_id: 0)

#       expect(Condition.highest_number_of_rides_from_temp(50)).to eq(1)
#     end

#     it 'finds the highest number of rides on a day with no condition' do

#       expect(Condition.highest_number_of_rides_from_temp(50)).to eq(0)
#     end
#   end

#   describe '.lowest_number_of_rides_from_temp' do
#     it 'finds the lowest number of rides on any day within the temperature range where is only one trip' do
#       condition = Condition.create(date: "01/01/2015", max_temperature: 55)
#       trip = condition.trips.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: 0, bike_id: 0, zip_code: 0, station_id: 0, subscription_type_id: 0)

#       expect(Condition.lowest_number_of_rides_from_temp(50)).to eq(1)
#     end

#     it 'finds the lowest number of rides on any day within the temperature range with two trips' do
#       condition = Condition.create(date: "01/01/2015", max_temperature: 55)
#       trip = condition.trips.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: 0, bike_id: 0, zip_code: 0, station_id: 0, subscription_type_id: 0)
#       trip = condition.trips.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: 0, bike_id: 0, zip_code: 0, station_id: 0, subscription_type_id: 0)

#       expect(Condition.lowest_number_of_rides_from_temp(50)).to eq(2)
#     end

#     it 'finds the lowest number of rides on any day within the temperature range with two conditions' do
#       condition_one = Condition.create(date: "01/01/2015", max_temperature: 55)
#       condition_two = Condition.create(date: "01/02/2015", max_temperature: 55)
#       trip = condition_one.trips.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: 0, bike_id: 0, zip_code: 0, station_id: 0, subscription_type_id: 0)
#       trip = condition_two.trips.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: 0, bike_id: 0, zip_code: 0, station_id: 0, subscription_type_id: 0)

#       expect(Condition.lowest_number_of_rides_from_temp(50)).to eq(1)
#     end

#     it 'finds the lowest number of rides on a day with no condition' do

#       expect(Condition.lowest_number_of_rides_from_temp(50)).to eq(0)
#     end
#   end
# end