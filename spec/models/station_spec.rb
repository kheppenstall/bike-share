require './spec/spec_helper'

describe "Station" do
  describe "attributes" do

    before :each do
      @station = Station.create(name: "Dock", dock_count: 20, installation_date: "07/21/2009", city_id: 2)
    end

    it "has name" do
      expect(@station.name).to eq("Dock")
    end

    it "has dock count" do
      expect(@station.dock_count).to eq(20)
    end

    it "has an installation date" do
      expect(@station.installation_date).to eq("07/21/2009")
    end

    it "has a city id" do
      expect(@station.city_id).to eq(2)
    end
  end

  describe "validates" do
    it "presence of name" do
      invalid_station = Station.create(dock_count: 20, installation_date: "07/21/2009", city_id: 2)

      expect(invalid_station).to be_invalid
    end

    it "presence of dock count" do
      invalid_station = Station.create(name: "Dock", installation_date: "07/21/2009", city_id: 2)

      expect(invalid_station).to be_invalid
    end

    it "presence of installation date" do
      invalid_station = Station.create(name: "Dock", dock_count: 20, city_id: 2)

      expect(invalid_station).to be_invalid
    end

    it "presence of city id" do
      invalid_station = Station.create(name: "Dock", dock_count: 20, installation_date: "07/21/2009")

      expect(invalid_station).to be_invalid
    end

    it "uniqueness of name" do
      valid_station = Station.create(name: "Dock", dock_count: 20, installation_date: "07/21/2009", city_id: 2)
      invalid_station = Station.create(name: "Dock", dock_count: 20, installation_date: "07/21/2009", city_id: 2)

      expect(valid_station).to be_valid
      expect(invalid_station).to be_invalid
    end
  end

  describe "associates" do
    it "with city" do
      city = City.create(name: "denver")
      station = city.stations.create(name: "Dock", dock_count: 20, installation_date: "07/21/2009")

      expect(station.city_id).to eq(city.id)
    end
  end
end
