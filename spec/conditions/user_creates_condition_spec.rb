require './spec/spec_helper'

describe "user visits /conditions/new" do

  it "user sees create condition message" do
    visit('/conditions/new')

    expect(page).to have_content("Create a New Condition")
  end

  it "user sees form" do
    visit('/conditions/new')

    expect(page).to have_content("Date:")
    expect(page).to have_content("Max Temperature:")
    expect(page).to have_content("Mean Temperature:")
    expect(page).to have_content("Minimum Temperature:")
  end

  it "user can enter a new condition" do
    visit('/conditions/new')

    fill_in 'condition[date]', with: "01/01/2015"
    fill_in 'condition[max_temp]', with: 20
    fill_in 'station[installation_date]', with: "01/01/2009"
    fill_in 'city', with: "San Fransisco"

    click_on 'Submit'

    station = Station.find_by(name: "Dock")
    city = City.find_by(name: "San Fransisco")

    expect(current_path).to eq("/stations/#{station.id}")
    expect(page).to have_content("Dock")
    expect(page).to have_content("San Fransisco")
    expect(page).to have_content("20")
    expect(page).to have_content("Thu, 01 Jan 2009")
    expect(station.city_id).to eq(city.id)
  end

end
