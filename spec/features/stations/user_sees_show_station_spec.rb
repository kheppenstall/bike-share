require './spec/spec_helper'

describe "when user visits /stations/:id" do
  before :each do
    @city = City.create(name: "Denver")
    @station = @city.stations.create(name: "Dock", dock_count: 20, installation_date: "01/01/2009")
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

  it "user returns to index" do
    visit("/stations/#{@station.id}")

    click_on "Return"

    expect(current_path).to eq("/stations")
  end

  it "user edits a station" do
    visit("/stations/#{@station.id}")

    click_on("Edit")

    expect(current_path).to eq("/stations/#{@station.id}/edit")
  end
end
