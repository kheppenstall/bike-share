require './spec/spec_helper'

describe "when user visits /conditions" do
  it "user sees a condition message" do
    visit('/conditions')

    expect(page).to have_content("Conditions")
  end

  it "user sees a condition's date" do
    condition = Condition.create(date: "Thu, 01 Jan 2015")

    visit('/conditions')

    expect(page).to have_content(condition.date)
  end

  it "user sees two conditions" do
    condition_1 = Condition.create(date: "Thu, 01 Jan 2015")
    condition_2 = Condition.create(date: "Thu, 01 Jan 2016")

    visit('/conditions')

    expect(page).to have_content(condition_1.date)
    expect(page).to have_content(condition_2.date)
  end

  it "and clicks station user visits station page" do
    condition_1 = Condition.create(date: "Thu, 01 Jan 2015")
    visit('/conditions')
    click_link("#{condition_1.name}, #{condition_1.city.name}")

    expect(current_path).to eq("/conditions/#{condition_1.id}")
  end
  #
  # it "and clicks to create a new station user visits new station page" do
  #   visit('/stations')
  #   click_link("Create a New Station")
  #
  #   expect(current_path).to eq("/stations/new")
  # end
  #
  #  it "and clicks station dashboard user visits dashboard page" do
  #   visit('/stations')
  #   click_link("Dashboard")
  #
  #   expect(current_path).to eq("/stations-dashboard")
  # end
end
