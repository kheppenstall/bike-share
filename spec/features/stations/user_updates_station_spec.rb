require './spec/spec_helper'

describe "user visits /stations/:id/edit" do

  before :each do
    @city = City.create(name: "Denver")
    @station = @city.stations.create(name: "Original", dock_count: 0, installation_date: "00/00/0000")
  end

  it "and sees form with attributes filled in" do
    visit("/stations/#{@station.id}/edit")

    expect(page).to have_content("Update Station")
    expect(page).to have_content("Name:")
    expect(page).to have_content("Dock Count:")
    expect(page).to have_content("Installation Date:")
    expect(page).to have_content("City:")
  end

  it "and sees station page after submitting updates" do
    visit("/stations/#{@station.id}/edit")

    click_on "Submit"
    expect(page).to have_content(@station.name)
    expect(page).to have_content(@station.dock_count)
    expect(page).to have_content(@station.installation_date)
    expect(page).to have_content(@station.city.name)
    expect(current_path).to eq("/stations/#{@station.id}")
  end

  it "and sees updated attributes on station page" do
    visit("/stations/#{@station.id}/edit")

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
