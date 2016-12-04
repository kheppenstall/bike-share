require './spec/spec_helper'

describe 'Station dashboard' do
  describe '.count' do
    it 'counts total stations when there are 0 stations' do

      expect(Station.count).to eq(0)
    end

    it 'counts total stations when there are stations' do
      Station.create(name: "Station One", dock_count: 0, installation_date: "01/01/2016", city_id: 1)

      expect(Station.count).to eq(1)
    end
  end

  describe '.average_bikes_per_station' do
    it 'calculates averages bikes per station' do
      Station.create(name: "Station One", dock_count: 0, installation_date: "01/01/2016", city_id: 1)
      Station.create(name: "Station Two", dock_count: 20, installation_date: "01/01/2016", city_id: 1)

      expect(Station.average_bikes_per_station).to eq(10)
    end

    it 'assigns average bike per station to 0 when there are no bikes' do
      expect(Station.average_bikes_per_station).to eq(0)
    end
  end

  describe '.station_with_most_bikes' do
    it 'finds station with most bikes available' do
      station_one = Station.create(name: "Station One", dock_count: 0, installation_date: "01/01/2016", city_id: 1)
      station_two = Station.create(name: "Station Two", dock_count: 20, installation_date: "01/01/2017", city_id: 1)

      expect(Station.station_with_most_bikes).to eq(station_two.name)
    end

    it 'finds multiple station with most bikes' do
      Station.create(name: "Station One", dock_count: 0, installation_date: "01/01/2016", city_id: 1)
      Station.create(name: "Station Two", dock_count: 0, installation_date: "01/01/2017", city_id: 1)

      expect(Station.station_with_most_bikes).to eq("Station One, Station Two")
    end

    it 'finds no station with most bikes when there are no stations' do

      expect(Station.station_with_most_bikes).to eq("")
    end
  end

  describe '.max_bike_count' do
    it 'finds the most bikes available at a station' do
      Station.create(name: "Station One", dock_count: 0, installation_date: "01/01/2016", city_id: 1)
      Station.create(name: "Station Two", dock_count: 20, installation_date: "01/01/2017", city_id: 1)

      expect(Station.max_bike_count).to eq(20)
    end

    it 'assigns 0 to the most bikes available at a station when there are no stations' do

      expect(Station.max_bike_count).to eq(0)
    end
  end

  describe '.station_with_fewest_bikes' do
    it 'finds station with fewest bikes available' do
      station_one = Station.create(name: "Station One", dock_count: 0, installation_date: "01/01/2016", city_id: 1)
      station_two = Station.create(name: "Station Two", dock_count: 20, installation_date: "01/01/2017", city_id: 1)

      expect(Station.station_with_fewest_bikes).to eq(station_one.name)
    end

    it 'finds multiple station with fewest bikes' do
      Station.create(name: "Station One", dock_count: 0, installation_date: "01/01/2016", city_id: 1)
      Station.create(name: "Station Two", dock_count: 0, installation_date: "01/01/2017", city_id: 1)

      expect(Station.station_with_fewest_bikes).to eq("Station One, Station Two")
    end

    it 'finds no station with fewest bikes when there are no stations' do
      expect(Station.station_with_fewest_bikes).to eq("")
    end
  end

  describe '.min_bike_count' do
    it 'finds the fewest bikes available at a station' do
      station_one = Station.create(name: "Station One", dock_count: 0, installation_date: "01/01/2016", city_id: 1)
      station_two = Station.create(name: "Station Two", dock_count: 20, installation_date: "01/01/2017", city_id: 1)

      expect(Station.min_bike_count).to eq(0)
    end

    it 'assigns 0 to the fewest bikes available at a station when there are no stations' do

      expect(Station.min_bike_count).to eq(0)
    end
  end

  describe '.newest_station' do
    it 'finds most recently installed station based on month' do
      station_one = Station.create(name: "Station One", dock_count: 0, installation_date: Date.strptime("01/22/2016", "%m/%d/%Y"), city_id: 1)
      station_two = Station.create(name: "Station Two", dock_count: 0, installation_date: Date.strptime("02/19/2016", "%m/%d/%Y"), city_id: 1)

      expect(Station.newest_station).to eq(station_two.name)
    end

    it 'finds most recently installed station based on year' do
      station_one = Station.create(name: "Station One", dock_count: 0, installation_date: Date.strptime("01/01/2011", "%m/%d/%Y"), city_id: 1)
      station_two = Station.create(name: "Station Two", dock_count: 0, installation_date: Date.strptime("02/23/2016", "%m/%d/%Y"), city_id: 1)

      expect(Station.newest_station).to eq(station_two.name)
    end

    it 'finds most recently installed station based on day' do
      station_one = Station.create(name: "Station One", dock_count: 0, installation_date: Date.strptime("02/22/2016", "%m/%d/%Y"), city_id: 1)
      station_two = Station.create(name: "Station Two", dock_count: 0, installation_date: Date.strptime("02/23/2016", "%m/%d/%Y"), city_id: 1)

      expect(Station.newest_station).to eq(station_two.name)
    end

    it 'finds no station as most recently installed when there are no stations' do
      expect(Station.newest_station).to eq("")
    end

    it 'finds no station as newest when installation date is in improper format' do
      station = Station.create(name: "Station One", dock_count: 0, installation_date: "Not a date", city_id: 1)

      expect(Station.newest_station).to eq("")
    end

    it 'finds station with a valid date as newest station' do
      valid_date_station   = Station.create(name: "Valid", dock_count: 0, installation_date: Date.strptime("02/22/2016", "%m/%d/%Y"), city_id: 1)
      invalid_date_station = Station.create(name: "Invalid", dock_count: 0, installation_date: "Not a date", city_id: 1)

      expect(Station.newest_station).to eq(valid_date_station.name)
    end
  end

  describe '.oldest_station' do
    it 'finds oldest station based on month' do
      station_one = Station.create(name: "Station One", dock_count: 0, installation_date: Date.strptime("01/22/2016", "%m/%d/%Y"), city_id: 1)
      station_two = Station.create(name: "Station Two", dock_count: 0, installation_date: Date.strptime("02/19/2016", "%m/%d/%Y"), city_id: 1)

      expect(Station.oldest_station).to eq(station_one.name)
    end

    it 'finds oldest station based on year' do
      station_one = Station.create(name: "Station One", dock_count: 0, installation_date: Date.strptime("01/01/2011", "%m/%d/%Y"), city_id: 1)
      station_two = Station.create(name: "Station Two", dock_count: 0, installation_date: Date.strptime("02/23/2016", "%m/%d/%Y"), city_id: 1)

      expect(Station.oldest_station).to eq(station_one.name)
    end

    it 'finds oldest station based on day' do
      station_one = Station.create(name: "Station One", dock_count: 0, installation_date: Date.strptime("02/22/2016", "%m/%d/%Y"), city_id: 1)
      station_two = Station.create(name: "Station Two", dock_count: 0, installation_date: Date.strptime("02/23/2016", "%m/%d/%Y"), city_id: 1)

      expect(Station.oldest_station).to eq(station_one.name)
    end

    it 'finds no station as oldest when there are no stations' do
      expect(Station.oldest_station).to eq("")
    end

    it 'finds no station as oldest when installation date is in improper format' do
      station = Station.create(name: "Station One", dock_count: 0, installation_date: "Not a date", city_id: 1)

      expect(Station.oldest_station).to eq("")
    end

    it 'finds station with a valid date as oldest station' do
      valid_date_station   = Station.create(name: "Valid", dock_count: 0, installation_date: Date.strptime("02/22/2016", "%m/%d/%Y"), city_id: 1)
      invalid_date_station = Station.create(name: "Invalid", dock_count: 0, installation_date: "Not a date", city_id: 1)

      expect(Station.oldest_station).to eq(valid_date_station.name)
    end
  end
end
