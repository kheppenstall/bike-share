require './spec/spec_helper'

describe "user visits /conditions/:id/edit" do

  before :each do
    @condition = Condition.create(date: "Sat, 7 Mar 2015", max_temperature: 20)
  end

  it "and sees form with attributes filled in" do
    visit("/conditions/#{@condition.id}/edit")

    expect(page).to have_content("Edit Condition")

  end

  it "and sees condition page after submitting updates" do
    visit("/conditions/#{@condition.id}/edit")

    fill_in 'condition[max_temperature]', with: 30

    click_on "Submit"

    expect(page).to have_content(@condition.date.inspect)
    expect(page).to have_content(@condition.max_temperature)
    expect(page).to have_content(@condition.mean_temperature)
    expect(page).to have_content(@condition.min_temperature)
    expect(page).to have_content(@condition.mean_humidity)
    expect(page).to have_content(@condition.mean_visibility)
    expect(page).to have_content(@condition.mean_wind_speed)
    expect(page).to have_content(@condition.precipitation)

    expect(current_path).to eq("/conditions/#{@condition.id}")
  end

  it "and sees updated attributes on condition page" do
    visit("/conditions/#{@condition.id}/edit")

    fill_in 'condition[max_temperature]', with: 20
    fill_in 'condition[mean_temperature]', with: 15
    fill_in 'condition[min_temperature]', with: 10
    fill_in 'condition[mean_humidity]', with: 25
    fill_in 'condition[mean_visibility]', with: 2
    fill_in 'condition[mean_wind_speed]', with: 5
    fill_in 'condition[precipitation]', with: 1.2

    click_on 'Submit'

    expect(current_path).to eq("/conditions/#{@condition.id}")
    expect(page).to have_content("10")
    expect(page).to have_content("15")
    expect(page).to have_content("10")
    expect(page).to have_content("25")
    expect(page).to have_content("2")
    expect(page).to have_content("5")
    expect(page).to have_content("1.2")
  end
end
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
