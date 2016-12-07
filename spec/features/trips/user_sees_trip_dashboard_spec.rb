require './spec/spec_helper'

describe "when user visits /trips-dashboard" do
  it "user sees dashboard" do
    visit('/trips-dashboard')

    expect(page).to have_content("Trips Dashboard")
  end
end
