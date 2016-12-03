require './spec/spec_helper'

describe "user visits /stations/new" do

  it "user sees create message" do
    visit('/stations/new')

    expect(page).to have_content("Create a New Station")
  end

  it "user sees form" do
    visit('/stations/new')

    expect(page).to have_content("Name:")
    expect(page).to have_content("Dock Count:")
    expect(page).to have_content("Installation Date:")
    expect(page).to have_content("City:")
  end

  it "user can create a new station" do
    visit('/stations/new')

    fill_in 'station[name]', with: "Dock"
    fill_in 'station[dock_count]', with: 20
    fill_in 'station[installation_date]', with: "07/21/2009"
    fill_in 'city', with: "San Fransisco"

    click_on 'Submit'

    station = Station.find_by(name: "Dock")
    city = City.find_by(name: "San Fransisco")

    expect(current_path).to eq("/stations/#{station.id}")
    expect(page).to have_content("Dock")
    expect(page).to have_content("San Fransisco")
    expect(page).to have_content("20")
    expect(page).to have_content("07/21/2009")
    expect(station.city_id).to eq(city.id)
  end

end
