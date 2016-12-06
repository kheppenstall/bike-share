require './spec/spec_helper'

describe "When a user deletes a trip" do
  it "it is removed" do
    start_station = Station.create(name: "Dock", dock_count: 20, installation_date: "01/01/2015", city_id: 1)
    end_station   = Station.create(name: "Dock1", dock_count: 20, installation_date: "01/01/2015", city_id: 1)
    subscription  = SubscriptionType.create(name: "Customer")
    condition     = Condition.create(date: "01/03/2016")
    trip          = start_station.trips.create(duration: 300, start_date: "01/01/2016",
                        end_date: "02/01/2016", end_station_id: end_station.id,
                        bike_id: 14, zip_code: 80918, station_id: start_station.id,
                        condition_id: 2, subscription_type_id: subscription.id)

    visit("/trips/#{trip.id}")

    click_on "Delete"

    expect(current_path).to eq('/trips/page/1')
    expect(page).to_not have_content(trip.start_date)
  end
end
