require './spec/spec_helper'

describe "when user visits /stations" do
  it "user sees a message" do
    visit('/stations')

    expect(page).to have_content("Stations")
  end

  it "user sees a station's name" do
    city = City.create(name: "Denver")
    station = city.stations.create(name: "Dock", dock_count: 20, installation_date: "01/01/2009")
    visit('/stations')

    expect(page).to have_content(station.name)
  end

  it "user sees two stations" do
    city = City.create(name: "Denver")
    dock_1 = city.stations.create(name: "Dock_1", dock_count: 20, installation_date: "01/01/2009")
    dock_2 = city.stations.create(name: "Dock_2", dock_count: 20, installation_date: "01/01/2009")
    visit('/stations')

    expect(page).to have_content(dock_1.name)
    expect(page).to have_content(dock_2.name)
  end

  it "and clicks station user visits station page" do
    city = City.create(name: "Denver")
    dock_1 = city.stations.create(name: "Dock_1", dock_count: 20, installation_date: "01/01/2009")
    visit('/stations')
    click_link("#{dock_1.name}, #{dock_1.city.name}")

    expect(current_path).to eq("/stations/#{dock_1.id}")
  end

  it "and clicks to create a new station user visits new station page" do
    visit('/stations')
    click_link("Create a New Station")

    expect(current_path).to eq("/stations/new")
  end

   it "and clicks station dashboard user visits dashboard page" do
    visit('/stations')
    click_link("Dashboard")

    expect(current_path).to eq("/stations-dashboard")
  end
end
