require './spec/spec_helper'

describe "City" do
  describe "attributes" do

    before :each do
      @city = City.create(name: "Denver")
    end

    it "has id" do
      expect(@city.id).to eq(1)
    end

    it "has name" do
      expect(@city.name).to eq("Denver")
    end
  end

  describe "validates" do
    it "presence of name" do
      invalid_city = City.create()

      expect(invalid_city).to be_invalid
    end

    it "uniqueness of name" do
      valid_city = City.create(name: "Denver")
      invalid_city = City.create(name: "Denver")

      expect(valid_city).to be_valid
      expect(invalid_city).to be_invalid
    end
  end

  describe "associations" do
    before :each do
      @city = City.create(name: "Denver")
    end

    it "with one station" do
      station = @city.stations.create(name: "Dock", dock_count: 20, installation_date: "01/01/2009")

      expect(@city.id).to eq(station.id)
    end

    it "with multiple stations" do
      station_one = @city.stations.create(name: "Dock_One", dock_count: 20, installation_date: "01/01/2009")
      station_two = @city.stations.create(name: "Dock_Two", dock_count: 20, installation_date: "01/01/2009")

      expect(@city.id).to eq(station_one.city_id)
      expect(@city.id).to eq(station_two.city_id)
    end
  end
end