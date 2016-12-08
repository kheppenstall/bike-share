require './spec/spec_helper'

describe "user visits /trips/:id/edit" do
  before :each do
    @start_station = Station.create(name: "Dock", dock_count: 20, installation_date: "01/01/2015", city_id: 1)
    @end_station   = Station.create(name: "Dock1", dock_count: 20, installation_date: "01/01/2015", city_id: 1)
    @subscription  = SubscriptionType.create(name: "Customer")
    @condition     = Condition.create(date: "01/03/2016")
    @trip          = @start_station.trips.create(duration: 300, start_date: "01/01/2016",
                        end_date: "02/01/2016", end_station_id: @start_station.id,
                        bike_id: 14, zip_code: 80918, station_id: @start_station.id,
                        condition_id: 2, subscription_type_id: @subscription.id)
  end

  it "and sees form with attributes filled in" do
    visit("/trips/#{@trip.id}/edit")

    expect(page).to have_content("Start Station: ")
    expect(page).to have_content("Start Date: ")
    expect(page).to have_content("End Station: ")
    expect(page).to have_content("End Date: ")
    expect(page).to have_content("Bike ID: ")
    expect(page).to have_content("Zip Code: ")
  end

  it "and clicks submit" do

    visit("/trips/#{@trip.id}/edit")

    fill_in "trip[bike_id]", with: 15
    fill_in "trip[zip_code]", with: 80919
    fill_in "trip[start_date]", with: "01/03/2016 01:00:00"
    fill_in "trip[end_date]", with: "01/04/2016 01:00:00"

    click_on("Submit")

    expect(current_path).to eq("/trips/#{@trip.id}")
    expect(page).to have_content(15)
    expect(page).to_not have_content(14)
    expect(page).to have_content(80919)
    expect(page).to_not have_content(80918)
  end
end
