require './spec/spec_helper'

describe "user visits /trips/new" do
  it "user sees create message" do
    visit('/trips/new')

    expect(page).to have_content("Create a Trip")
  end
end
