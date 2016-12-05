require './spec/spec_helper'

describe "when user visits /trips/:id" do
  before :each do
    @start_station = Station.create(name: "Dock", dock_count: 20, installation_date: "01/01/2015", city_id: 1)
    @final_station = Station.create(name: "Dock1", dock_count: 20, installation_date: "01/01/2015", city_id: 1)
    @subscription  = SubscriptionType.create(name: "Customer")
    @trip          = @subscription.trips.create(duration: 300, start_date: "01/01/2016",
                        end_date: "02/01/2016", station_id: @start_station.id, end_station_id: @final_station.id,
                        bike_id: 14, zip_code: 80918, condition_id: 2)
  end

  it "user sees trip date" do
    visit("/trips/#{@trip.id}")

    expect(page).to have_content("#{@trip.start_date}")
  end

  it "user sees trip attributes" do
    visit("/trips/#{@trip.id}")

    expect(page).to have_content(@trip.start_date)
    expect(page).to have_content(@start_station.name)
    expect(page).to have_content(@trip.end_date)
    expect(page).to have_content(@final_station.name)
    expect(page).to have_content(@trip.duration)
    expect(page).to have_content(@trip.zip_code)
    expect(page).to have_content(@trip.bike_id)
    expect(page).to have_content(@subscription.name)
  end

  it "user sees a button to the trips conditions" do
    visit("/trips/#{@trip.id}")

    click_on("Weather Conditions")

    expect(current_path).to eq("/conditions/#{@trip.condition_id}")
  end

  it "user clicks edit button" do
    visit("/trips/#{@trip.id}")

    click_on("Edit")

    expect(current_path).to eq("/trips/#{@trip.id}/edit")
  end

  it "user clicks delete button" do
    visit("/trips/#{@trip.id}")

    click_on("Delete")

    expect(current_path).to eq('/trips/page/1')
  end
end
