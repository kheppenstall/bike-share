require './spec/spec_helper'

describe "user visits /trips/new" do
  it "and sees create message" do
    visit('/trips/new')

    expect(page).to have_content("Create a Trip")
  end

  it "and sees form" do
    visit('/trips/new')

    expect(page).to have_content("Start Station: ")
    expect(page).to have_content("Start Date: ")
    expect(page).to have_content("End Station: ")
    expect(page).to have_content("End Date: ")
    expect(page).to have_content("Bike ID: ")
    expect(page).to have_content("Zip Code: ")
  end

  it "and creates a new trip" do
    station   = Station.create(name: "Station", dock_count: 20, installation_date: "02/01/1990", city_id: 1)
    subtype   = SubscriptionType.create(name: "Customer")
    condition = Condition.create(date: "01/02/2016")

    visit('/trips/new')

    fill_in "trip[bike_id]", with: 14
    fill_in "trip[zip_code]", with: 80918
    fill_in "trip[start_date]", with: "01/02/2016 01:00:00"
    fill_in "trip[end_date]", with: "01/02/2016 01:01:00"

    click_on("Submit")

    expect(current_path).to eq("/trips/1")
    expect(page).to have_content("Station")
    expect(page).to have_content("Duration of Trip: ")
    expect(page).to have_content("Zip Code: ")
    expect(page).to have_content("Bike ID: ")
    expect(page).to have_content(14)
    expect(page).to have_content(80918)
  end
end
