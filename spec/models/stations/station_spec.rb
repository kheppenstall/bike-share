require './spec/spec_helper'

describe "Station" do
  describe "attributes" do

    before :each do
      @station = Station.create(name: "Dock", dock_count: 20, installation_date: "01/01/2015", city_id: 2)
    end

    it "has an id" do
      expect(@station.id).to eq(1)
    end

    it "has name" do
      expect(@station.name).to eq("Dock")
    end

    it "has dock count" do
      expect(@station.dock_count).to eq(20)
    end

    it "has an installation date" do
      expect(@station.installation_date.inspect).to eq("Thu, 01 Jan 2015")
    end

    it "has a city id" do
      expect(@station.city_id).to eq(2)
    end
  end

  describe "validates" do
    it "presence of name" do
      invalid_station = Station.create(dock_count: 20, installation_date: "01/01/2015", city_id: 2)

      expect(invalid_station).to be_invalid
    end

    it "presence of dock count" do
      invalid_station = Station.create(name: "Dock", installation_date: "01/01/2015", city_id: 2)

      expect(invalid_station).to be_invalid
    end

    it "presence of installation date" do
      invalid_station = Station.create(name: "Dock", dock_count: 20, city_id: 2)

      expect(invalid_station).to be_invalid
    end

    it "presence of city id" do
      invalid_station = Station.create(name: "Dock", dock_count: 20, installation_date: "01/01/2015")

      expect(invalid_station).to be_invalid
    end

    it "uniqueness of name" do
      valid_station   = Station.create(name: "Dock", dock_count: 20, installation_date: "01/01/2015", city_id: 2)
      invalid_station = Station.create(name: "Dock", dock_count: 20, installation_date: "01/01/2015", city_id: 2)

      expect(valid_station).to be_valid
      expect(invalid_station).to be_invalid
    end
  end

  describe "associates" do
    it "with city" do
      city = City.create(name: "denver")
      station = city.stations.create(name: "Dock", dock_count: 20, installation_date: "01/01/2015")

      expect(station.city).to eq(city)
    end

     it "with trips" do
      station = Station.create(name: "Dock", dock_count: 20, installation_date: "01/01/2015", city_id: 2)
      trip = station.trips.create(duration: 300, start_date: "01/01/2016", end_date: "02/01/2016", end_station_id: 5, bike_id: 14, zip_code: 80918, condition_id: 2, subscription_type_id: 1)

      expect(trip.station).to eq(station)
    end

    it "with conditions through trips" do
      station = Station.create(name: "Dock", dock_count: 20, installation_date: "01/01/2015", city_id: 2)
      condition = Condition.create(date:"01/01/2016")
      trip = station.trips.create(duration: 300, start_date: "01/01/2016", end_date: "02/01/2016", end_station_id: 5, bike_id: 14, zip_code: 80918, condition_id: condition.id, subscription_type_id: 1)

      expect(station.conditions.first).to eq(condition)
    end
  end
  
  describe '.rides_started_at_station' do
    it 'returns 0 when no rides were started at station' do
      station = Station.create(name: "Station One", dock_count: 0, installation_date: "Not a date", city_id: 1)

      expect(station.rides_started_at_station).to eq(0)
    end

    it 'returns the number of rides started at the station' do
      station = Station.create(name: "Station One", dock_count: 0, installation_date: Date.strptime("02/22/2016", "%m/%d/%Y"), city_id: 1)
      station.trips.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: 0, bike_id: 0, zip_code: 0, station_id: 0, subscription_type_id: 0)
    
      expect(station.rides_started_at_station).to eq(1)
    end

    it 'does not include rides ended at the station' do
      station = Station.create(name: "Station One", dock_count: 0, installation_date: Date.strptime("02/22/2016", "%m/%d/%Y"), city_id: 1)
      Trip.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: 0, bike_id: 0, zip_code: 0, station_id: 0, subscription_type_id: 0)
    
      expect(station.rides_started_at_station).to eq(0)
    end
  end

  describe '.rides_ended_at_station' do
    it 'returns 0 when no rides were ended at station' do
      station = Station.create(name: "Station One", dock_count: 0, installation_date: "Not a date", city_id: 1)

      expect(station.rides_ended_at_station).to eq(0)
    end

    it 'returns the number of rides ended at the station' do
      station = Station.create(name: "Station One", dock_count: 0, installation_date: Date.strptime("02/22/2016", "%m/%d/%Y"), city_id: 1)
      Trip.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: station.id, bike_id: 0, zip_code: 0, station_id: 0, subscription_type_id: 0)
    
      expect(station.rides_ended_at_station).to eq(1)
    end

    it 'does not include rides not ended at the station' do
      station = Station.create(name: "Station One", dock_count: 0, installation_date: Date.strptime("02/22/2016", "%m/%d/%Y"), city_id: 1)
      Trip.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: -1, bike_id: 0, zip_code: 0, station_id: 0, subscription_type_id: 0)
    
      expect(station.rides_ended_at_station).to eq(0)
    end
  end

  describe '.most_frequent_destination' do
    it 'returns the station where the most trips end' do
      station_one = Station.create(name: "Station One", dock_count: 0, installation_date: Date.strptime("02/22/2016", "%m/%d/%Y"), city_id: 1)
      station_two = Station.create(name: "Station Two", dock_count: 0, installation_date: Date.strptime("02/23/2016", "%m/%d/%Y"), city_id: 1)

      station_one.trips.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: station_one.id, bike_id: 0, zip_code: 0, subscription_type_id: 0)
      station_one.trips.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: station_two.id, bike_id: 0, zip_code: 0, subscription_type_id: 0)
      station_one.trips.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: station_two.id, bike_id: 0, zip_code: 0, subscription_type_id: 0)
    
      expect(station_one.most_frequent_destination).to eq("Station Two")
    end

    it 'returns nil for stations with no trips' do
      station_one = Station.create(name: "Station One", dock_count: 0, installation_date: Date.strptime("02/22/2016", "%m/%d/%Y"), city_id: 1)
    
      expect(station_one.most_frequent_destination).to eq(nil)
    end
  end

  describe '.most_frequent_origin' do
    it 'returns the station where the most trips originated' do
      station_one = Station.create(name: "Station One", dock_count: 0, installation_date: Date.strptime("02/22/2016", "%m/%d/%Y"), city_id: 1)
      station_two = Station.create(name: "Station Two", dock_count: 0, installation_date: Date.strptime("02/23/2016", "%m/%d/%Y"), city_id: 1)

      station_one.trips.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: station_one.id, bike_id: 0, zip_code: 0, subscription_type_id: 0)
      station_one.trips.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: station_two.id, bike_id: 0, zip_code: 0, subscription_type_id: 0)
      station_one.trips.create(duration: 0, start_date: "01/01/2015", end_date: "01/01/2015", end_station_id: station_two.id, bike_id: 0, zip_code: 0, subscription_type_id: 0)
    
      expect(station_two.most_frequent_origin).to eq("Station One")
    end

    it 'returns the nil for stations with no trips' do
      station_one = Station.create(name: "Station One", dock_count: 0, installation_date: Date.strptime("02/22/2016", "%m/%d/%Y"), city_id: 1)
    
      expect(station_one.most_frequent_origin).to eq(nil)
    end
  end
end