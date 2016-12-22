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

  it "and clicks condition user visits condition page" do
    condition = Condition.create(date: "Thu, 01 Jan 2015")

    visit('/conditions')

    click_on "#{condition.date}"

    expect(current_path).to eq("/conditions/#{condition.id}")
  end

  it "and clicks to create a new condition user visits new condition page" do
    visit('/conditions')

    click_link("Create a New Condition")

    expect(current_path).to eq("/conditions/new")
  end
end
