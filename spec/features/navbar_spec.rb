require './spec/spec_helper'

describe "user visits / and dashboard includes" do
  it "Trips, stations, and weather" do
    visit('/')

    expect(page).to have_content("Stations")
    expect(page).to have_content("Trips")
    expect(page).to have_content("Weather")
  end
end