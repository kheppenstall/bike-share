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

  it "and sees 15 trip links" do
    (30..44).each do |n|
      Trip.create(duration: 300, start_date: "01/01/19#{n}",
                          end_date: "02/01/2016", end_station_id: 4,
                          bike_id: 14, zip_code: 80918, station_id: 3,
                          condition_id: 2, subscription_type_id: 1)
    end

    visit('/trips/page/1')

    expect(page).to have_content("1930")
    expect(page).to have_content("1944")

    click_on('Next')
    expect(current_path).to eq('/trips/page/1')

    click_on('Previous')
    expect(current_path).to eq('/trips/page/1')

  end

  it "and sees 30 trip links on each page" do
    (30..65).each do |n|
      Trip.create(duration: 300, start_date: "01/01/19#{n}",
                            end_date: "02/01/2016", end_station_id: 4,
                            bike_id: 14, zip_code: 80918, station_id: 3,
                            condition_id: 2, subscription_type_id: 1)
    end

    visit('/trips/page/1')

    expect(page).to have_content("1930")
    expect(page).to have_content("1959")
    expect(page).to_not have_content("1960")
    expect(page).to_not have_content("1965")
    expect(current_path).to eq('/trips/page/1')


    click_on('Next')

    expect(page).to_not have_content("1930")
    expect(page).to_not have_content("1959")
    expect(page).to have_content("1960")
    expect(page).to have_content("1965")
    expect(current_path).to eq('/trips/page/2')

    click_on('Next')

    expect(current_path).to eq('/trips/page/2')

    click_on('Previous')

    expect(page).to have_content("1930")
    expect(page).to have_content("1959")
    expect(page).to_not have_content("1960")
    expect(page).to_not have_content("1965")
    expect(current_path).to eq('/trips/page/1')
  end
end
