require './spec/spec_helper'

describe "When user deletes a station" do
  it "it is removed" do
    @city = City.create(name: "Denver")
    @station = @city.stations.create(name: "Dock", dock_count: 20, installation_date: "07/21/2009")

    visit("/stations/#{@station.id}")

    click_on "Delete"

    expect(current_path).to eq('/stations')
    expect(page).to_not have_content(@station.name)
  end
end
