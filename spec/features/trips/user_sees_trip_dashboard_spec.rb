require './spec/spec_helper'

describe "when user visits /stations-dashboard" do
  it "user sees dashboard" do
    visit('/trips-dashboard')

    expect(page).to have_content("Trips Dashboard")
  end
end
