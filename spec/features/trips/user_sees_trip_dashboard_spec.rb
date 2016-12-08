require './spec/spec_helper'

describe "when user visits /trips-dashboard" do
  it "and sees welcome message" do
    visit('/trips-dashboard')

    expect(page).to have_content("Trips Dashboard")
  end
end
