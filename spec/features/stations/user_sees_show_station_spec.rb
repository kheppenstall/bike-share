require './spec/spec_helper'

describe "when user visits /stations/:id" do
  before :each do
    @city = City.create(name: "Denver")
    @station = @city.stations.create(name: "Dock", dock_count: 20, installation_date: "07/21/2009")
  end

  it "user sees station name" do
    visit("/stations/#{@station.id}")

    expect(page).to have_content("#{@station.name}")
  end

  it "user sees station attributes" do
    visit("/stations/#{@station.id}")

    expect(page).to have_content("#{@station.city.name}")
    expect(page).to have_content("#{@station.dock_count}")
    expect(page).to have_content("#{@station.installation_date}")
  end
end
