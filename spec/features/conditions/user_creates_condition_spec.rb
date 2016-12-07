require './spec/spec_helper'

describe "user visits /conditions/new" do

  it "user sees create condition message" do
    visit('/conditions/new')

    expect(page).to have_content("Create a New Condition")
  end

  it "user sees the Conditions form" do
    visit('/conditions/new')

    expect(page).to have_content("Date:")
    expect(page).to have_content("Max Temperature:")
    expect(page).to have_content("Mean Temperature:")
    expect(page).to have_content("Minimum Temperature:")
  end

  it "user can enter a new condition" do
    visit('/conditions/new')

    fill_in 'condition[date]', with: "01/01/2015"
    fill_in 'condition[max_temperature]', with: 20
    fill_in 'condition[mean_temperature]', with: 12
    fill_in 'condition[min_temperature]', with: 10
    fill_in 'condition[mean_humidity]', with: 37
    fill_in 'condition[mean_visibility]', with: 2
    fill_in 'condition[mean_wind_speed]', with: 22
    fill_in 'condition[precipitation]', with: 1.2

    click_on 'Submit'

    condition = Condition.find_by(date: "01/01/2015")

    expect(current_path).to eq("/conditions/#{condition.id}")
    expect(page).to have_content("Thu, 01 Jan 2015")
    expect(page).to have_content("20")
    expect(page).to have_content("12")
    expect(page).to have_content("10")
    expect(page).to have_content("37")
    expect(page).to have_content("2")
    expect(page).to have_content("22")
    expect(page).to have_content("1.2")


  end
end
