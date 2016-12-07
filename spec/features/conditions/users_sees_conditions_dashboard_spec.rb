require './spec/spec_helper'

describe "when user visits /conditions-dashboard" do
  it "user sees dashboard" do
    visit('/conditions-dashboard')

    expect(page).to have_content("Weather Dashboard")
  end

  describe "and the dashboard displays" do

    it "average number of rides" do
      visit('/conditions-dashboard')

      expect(page).to have_content("Average Number of Rides")
    end

    it "highest number of rides" do
      visit('/conditions-dashboard')

      expect(page).to have_content("Highest Number of Rides")
    end

    it "lowest number of rides" do
      visit('/conditions-dashboard')

      expect(page).to have_content("Lowest Number of Rides")
    end

    it "precipitation" do
      visit('/conditions-dashboard')

      expect(page).to have_content("Precipitation")
    end

    it "wind speed" do
      visit('/conditions-dashboard')

      expect(page).to have_content("Wind Speed")
    end

    it "temperature" do
      visit('/conditions-dashboard')

      expect(page).to have_content("Temperature")
    end

    it "visibility" do
      visit('/conditions-dashboard')

      expect(page).to have_content("Visibility")
    end
  end
end
