require './spec/spec_helper'

describe "when user visits /trips-dashboard" do
  it "and sees welcome message" do
    visit('/trips-dashboard')

    expect(page).to have_content("Trips Dashboard")
  end

  it "and sees relevant information" do
    visit('/trips-dashboard')

    expect(page).to have_content("Average Duration:")
    expect(page).to have_content("Longest Ride: ")
    expect(page).to have_content("Shortest Ride")
    expect(page).to have_content("Station with the most rides as starting place: ")
    expect(page).to have_content("Station with the most rides as starting place: ")
    expect(page).to have_content("Most Ridden Bike ID: ")
    expect(page).to have_content("Least Ridden Bike ID: ")
    expect(page).to have_content("Subscribers: ")
    expect(page).to have_content("Customers: ")
    expect(page).to have_content("Date with Most Trips: ")
    expect(page).to have_content("Conditions for date with most trips: ")
    expect(page).to have_content("Date with Least Trips:  ")
    expect(page).to have_content("Conditions for date with least trips: ")
  end

  it "and sees the trips table" do
    visit('/trips-dashboard')

    expect(page).to have_content("Bike Trips by Month")
    expect(page).to have_content(2013)
    expect(page).to have_content(2014)
    expect(page).to have_content(2015)
  end
end
