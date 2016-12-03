require './spec/spec_helper'

describe "when user visits /stations-dashboard" do
  it "user sees dashboard" do
    visit('/stations-dashboard')

    expect(page).to have_content("Stations Dashboard")
  end

  describe "the dashboard displays" do
    before :each do
      @station_one = Station.create(name: "Station Two", dock_count: 20, installation_date: "07/21/2009", city_id: 1)
      @station_two = Station.create(name: "Station One", dock_count: 0, installation_date: "08/05/2004", city_id: 1)
    end

    it "total count" do
      visit('/stations-dashboard')
      expect(page).to have_content("Total count: #{Station.count}")
    end

    it "average bikes available per station" do
      visit('/stations-dashboard')
      expect(page).to have_content("Average bikes available per station: #{Station.average_bikes_per_station}")
    end

    it "most bikes available at a station" do
      visit('/stations-dashboard')
      expect(page).to have_content("Most bikes available at a station: #{Station.max_bike_count}")
    end

    it "station(s) with most bikes available" do
      visit('/stations-dashboard')
      expect(page).to have_content("Station(s) with most available bikes: #{Station.station_with_most_bikes}")
    end

    it "fewest bikes available at a station" do
      visit('/stations-dashboard')
      expect(page).to have_content("Fewest bikes available at a station: #{Station.min_bike_count}")
    end

    it "station(s) with fewest bikes available" do
      visit('/stations-dashboard')
      expect(page).to have_content("Station(s) with fewest available bikes: #{Station.station_with_fewest_bikes}")
    end

    it "most recently installed station" do
      visit('/stations-dashboard')
      expect(page).to have_content("Most recently installed station: #{Station.newest_station}")
    end

    it "oldest station" do
      visit('/stations-dashboard')
      expect(page).to have_content("Oldest station: #{Station.oldest_station}")
    end
  end
end

