# require './spec/spec_helper'

# describe 'Condition dashboard' do
#   describe '.average_number_of_rides' do
#     it 'calculates average number of trips given floor of ten degree chunk' do
#       Condition.create(date: "01/01/2015", max_temperature: 55)
#       condition = Condition.create(date: "01/01/2015", max_temperature: 55)
#       condition.trips.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: 0, bike_id: 0, zip_code: 0, station_id: 0, subscription_type_id: 0)

#       expect(Condition.average_number_of_rides(50, condition.date)).to eq(0.5)
#     end

#     it 'assigns average numer of rides to zero when there are no trips in range' do
      

#       expect(Condition.average_number_of_rides(0, condition.date)).to eq(0)
#     end

#     it 'calculates average number of trips only including those in range'

#   end
# end