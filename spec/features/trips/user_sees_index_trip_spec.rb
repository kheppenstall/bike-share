require './spec/spec_helper'

describe "when user visits /trips" do
  it "user sees a message" do
    visit('/trips')

    expect(page).to have_content("Trips")
  end

  it "user visits /trips/page/1" do
    start_station = Station.create(name: "Dock", dock_count: 20, installation_date: "01/01/2015", city_id: 1)
    end_station   = Station.create(name: "Dock1", dock_count: 20, installation_date: "01/01/2015", city_id: 1)
    trip          = start_station.trips.create(duration: 300, start_date: "01/01/2016",
                        end_date: "02/01/2016", end_station_id: end_station.id,
                        bike_id: 14, zip_code: 80918, station_id: 3,
                        condition_id: 2, subscription_type_id: 1)

    visit('/trips')

    expect(page).to have_content(trip.start_date)
    expect(page).to have_content(trip.end_date)
  end

end
