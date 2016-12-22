require './spec/spec_helper'

describe "Condition" do
  describe "attributes"

  before :each do
    @condition = Condition.create(date: "01/01/2015", max_temperature: 80, mean_temperature: 40, min_temperature: 20, mean_humidity: 17, mean_visibility: 2, mean_wind_speed: 50, precipitation: 1.2)
  end

  it "has an id" do

    expect(@condition.id).to eq(1)
  end

  it "has a date" do

    expect(@condition.date.inspect).to eq("Thu, 01 Jan 2015")
  end

  it "has max_temperature" do

    expect(@condition.max_temperature).to eq(80)
  end

  it "has mean_temperature" do

    expect(@condition.mean_temperature).to eq(40)
  end

  it "has min_temperature" do

    expect(@condition.min_temperature).to eq(20)
  end

  it "has mean_humidity" do

    expect(@condition.mean_humidity).to eq(17)
  end

  it "has mean_visibility" do

    expect(@condition.mean_visibility).to eq(2)
  end

  it "has mean_wind_speed" do

    expect(@condition.mean_wind_speed).to eq(50)
  end

  it "has precipitation" do

    expect(@condition.precipitation).to eq(1.2)
  end
end

describe "validates" do
  it "presence of date" do
    invalid_condition = Condition.create(max_temperature: 80, mean_temperature: 40, min_temperature: 20, mean_humidity: 17, mean_visibility: 2, mean_wind_speed: 50, precipitation: 1.2)

    expect(invalid_condition).to be_invalid
  end

  it "uniqueness of date" do
    valid_condition = Condition.create(date: "01/01/2015", max_temperature: 80, mean_temperature: 40, min_temperature: 20, mean_humidity: 17, mean_visibility: 2, mean_wind_speed: 50, precipitation: 1.2)
    invalid_condition = Condition.create(date: "01/01/2015", max_temperature: 80, mean_temperature: 40, min_temperature: 20, mean_humidity: 17, mean_visibility: 2, mean_wind_speed: 50, precipitation: 1.2)

    expect(valid_condition).to be_valid
    expect(invalid_condition).to be_invalid
  end
end

describe "associates" do
  it "with station through trips" do
    condition = Condition.create(date:                 "01/01/2016",
                                 max_temperature:      80,
                                 mean_temperature:     75,
                                 min_temperature:      70,
                                 mean_humidity:        93,
                                 mean_visibility:      10,
                                 mean_wind_speed:      5,
                                 precipitation:        0,
                                 )
    station = Station.create(name: "Dock", dock_count: 20, installation_date: "01/01/2015", city_id: 2)
    trip = station.trips.create(duration: 300, start_date: "01/01/2016", end_date: "02/01/2016", end_station_id: 5, bike_id: 14, zip_code: 80918, condition_id: condition.id, subscription_type_id: 1)

    expect(station.conditions.first).to eq(condition)
  end

  it "with trips" do
    condition = Condition.create(date:                 "01/01/2016",
                                 max_temperature:      80,
                                 mean_temperature:     75,
                                 min_temperature:      70,
                                 mean_humidity:        93,
                                 mean_visibility:      10,
                                 mean_wind_speed:      5,
                                 precipitation:        0,
                                 )
    trip = condition.trips.create(duration: 300, start_date: "01/01/2016", end_date: "02/01/2016", end_station_id: 5, bike_id: 14, zip_code: 80918, condition_id: 2, subscription_type_id: 1)

    expect(trip.condition_id).to eq(condition.id)
  end

end