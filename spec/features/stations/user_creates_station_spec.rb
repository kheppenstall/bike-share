require './spec/spec_helper'

describe "user visits /stations/new" do

  it "user sees create message" do
    visit('/stations/new')

    expect(page).to have_content("Create a New Station")
  end

  it "user sees form" do
    visit('/stations/new')

    expect(page).to have_content("Name:")
    expect(page).to have_content("Dock Count:")
    expect(page).to have_content("Installation Date:")
    expect(page).to have_content("City:")
  end
end
