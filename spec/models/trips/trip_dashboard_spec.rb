require './spec/spec_helper'


describe "Trip Dashboardd" do
  describe '.average_duration_of_ride' do
    it "calculates average duration of trips" do
      start_station = Station.create(name: "Dock", dock_count: 20, installation_date: "01/01/2015", city_id: 1)
      final_station = Station.create(name: "Dock1", dock_count: 20, installation_date: "01/01/2015", city_id: 1)
      subscription  = SubscriptionType.create(name: "Customer")
      condition     = Condition.create(date: "02/01/1990")
      trip          = subscription.trips.create(duration: 300, start_date: "01/01/2016",
                          end_date: "02/01/2016", station_id: start_station.id, end_station_id: final_station.id,
                          bike_id: 14, zip_code: 80918, condition_id: condition.id)
      trip_2        = subscription.trips.create(duration: 200, start_date: "01/01/2016",
                          end_date: "02/01/2016", station_id: start_station.id, end_station_id: final_station.id,
                          bike_id: 14, zip_code: 80918, condition_id: condition.id)

      expect(Trip.average_duration_of_ride).to eq(250)
    end

    it "returns an  average of zero if there are no trips" do

      expect(Trip.average_duration_of_ride).to eq(0)
    end
  end

  describe ".longest_ride" do
    before :each do
      start_station = Station.create(name: "Dock", dock_count: 20, installation_date: "01/01/2015", city_id: 1)
      final_station = Station.create(name: "Dock1", dock_count: 20, installation_date: "01/01/2015", city_id: 1)
      subscription  = SubscriptionType.create(name: "Customer")
      condition     = Condition.create(date: "02/01/1990")
      trip          = subscription.trips.create(duration: 300, start_date: "01/01/2016",
                          end_date: "02/01/2016", station_id: start_station.id, end_station_id: final_station.id,
                          bike_id: 14, zip_code: 80918, condition_id: condition.id)
      trip_2        = subscription.trips.create(duration: 200, start_date: "01/01/2016",
                          end_date: "02/01/2016", station_id: start_station.id, end_station_id: final_station.id,
                          bike_id: 14, zip_code: 80918, condition_id: condition.id)
    end

    it "calculates the longest ride" do

      expect(Trip.longest_ride).to eq(300)
    end

    it "returns zero if there are no trips" do
      Trip.delete_all

      expect(Trip.longest_ride).to eq(0)
    end
  end

  describe ".shortest_ride" do
    it "calculates the shortest ride" do
      start_station = Station.create(name: "Dock", dock_count: 20, installation_date: "01/01/2015", city_id: 1)
      final_station = Station.create(name: "Dock1", dock_count: 20, installation_date: "01/01/2015", city_id: 1)
      subscription  = SubscriptionType.create(name: "Customer")
      condition     = Condition.create(date: "02/01/1990")
      trip          = subscription.trips.create(duration: 300, start_date: "01/01/2016",
                          end_date: "02/01/2016", station_id: start_station.id, end_station_id: final_station.id,
                          bike_id: 14, zip_code: 80918, condition_id: condition.id)
      trip_2        = subscription.trips.create(duration: 200, start_date: "01/01/2016",
                          end_date: "02/01/2016", station_id: start_station.id, end_station_id: final_station.id,
                          bike_id: 14, zip_code: 80918, condition_id: condition.id)

      expect(Trip.shortest_ride).to eq(200)
    end

    it "returns zero if there are no trips" do

      expect(Trip.shortest_ride).to eq(0)
    end
  end

  describe ".start_station_with_most_rides" do

    it "finds the station with the most rides" do
      start_station = Station.create(name: "Dock", dock_count: 10, installation_date: "01/01/2015", city_id: 1)
      final_station = Station.create(name: "Dock1", dock_count: 20, installation_date: "01/01/2015", city_id: 1)
      subscription  = SubscriptionType.create(name: "Customer")
      condition     = Condition.create(date: "02/01/1990")
      trip          = subscription.trips.create(duration: 300, start_date: "01/01/2016",
                          end_date: "02/01/2016", station_id: final_station.id, end_station_id: final_station.id,
                          bike_id: 14, zip_code: 80918, condition_id: condition.id)
      trip_2        = subscription.trips.create(duration: 200, start_date: "01/01/2016",
                          end_date: "02/01/2016", station_id: final_station.id, end_station_id: final_station.id,
                          bike_id: 14, zip_code: 80918, condition_id: condition.id)

      expect(Trip.start_station_with_most_rides).to eq(final_station.name)
    end

    it "returns empty string if there are no trips" do

      expect(Trip.start_station_with_most_rides).to eq("")
    end
  end

  describe ".end_station_with_most_rides" do
    it "returns the end station withthe most rides" do
      start_station = Station.create(name: "Dock", dock_count: 20, installation_date: "01/01/2015", city_id: 1)
      final_station = Station.create(name: "Dock1", dock_count: 20, installation_date: "01/01/2015", city_id: 1)
      subscription  = SubscriptionType.create(name: "Customer")
      condition     = Condition.create(date: "02/01/1990")
      trip          = subscription.trips.create(duration: 300, start_date: "01/01/2016",
                          end_date: "02/01/2016", station_id: start_station.id, end_station_id: final_station.id,
                          bike_id: 14, zip_code: 80918, condition_id: condition.id)
      trip_2        = subscription.trips.create(duration: 200, start_date: "01/01/2016",
                          end_date: "02/01/2016", station_id: start_station.id, end_station_id: final_station.id,
                          bike_id: 14, zip_code: 80918, condition_id: condition.id)

      expect(Trip.end_station_with_most_rides).to eq(start_station.name)
    end

    it "returns an empty string if there is no station" do

      expect(Trip.end_station_with_most_rides).to eq("")
    end
  end

  describe ".best_bike" do
    it "returns the most popular bike id" do
      start_station = Station.create(name: "Dock", dock_count: 20, installation_date: "01/01/2015", city_id: 1)
      final_station = Station.create(name: "Dock1", dock_count: 20, installation_date: "01/01/2015", city_id: 1)
      subscription  = SubscriptionType.create(name: "Customer")
      condition     = Condition.create(date: "02/01/1990")
      trip          = subscription.trips.create(duration: 300, start_date: "01/01/2016",
                      end_date: "02/01/2016", station_id: start_station.id, end_station_id: final_station.id,
                      bike_id: 14, zip_code: 80918, condition_id: condition.id)
      trip_2        = subscription.trips.create(duration: 200, start_date: "01/01/2016",
                      end_date: "02/01/2016", station_id: start_station.id, end_station_id: final_station.id,
                      bike_id: 14, zip_code: 80918, condition_id: condition.id)
      trip_3        = subscription.trips.create(duration: 200, start_date: "01/01/2016",
                      end_date: "02/01/2016", station_id: start_station.id, end_station_id: final_station.id,
                      bike_id: 15, zip_code: 80918, condition_id: condition.id)

      expect(Trip.best_bike).to eq(14)
    end
  end

  describe ".worst_bike" do
    it "returns the least popular bike id" do
      start_station = Station.create(name: "Dock", dock_count: 20, installation_date: "01/01/2015", city_id: 1)
      final_station = Station.create(name: "Dock1", dock_count: 20, installation_date: "01/01/2015", city_id: 1)
      subscription  = SubscriptionType.create(name: "Customer")
      condition     = Condition.create(date: "02/01/1990")
      trip          = subscription.trips.create(duration: 300, start_date: "01/01/2016",
                      end_date: "02/01/2016", station_id: start_station.id, end_station_id: final_station.id,
                      bike_id: 14, zip_code: 80918, condition_id: condition.id)
      trip_2        = subscription.trips.create(duration: 200, start_date: "01/01/2016",
                      end_date: "02/01/2016", station_id: start_station.id, end_station_id: final_station.id,
                      bike_id: 14, zip_code: 80918, condition_id: condition.id)
      trip_3        = subscription.trips.create(duration: 200, start_date: "01/01/2016",
                      end_date: "02/01/2016", station_id: start_station.id, end_station_id: final_station.id,
                      bike_id: 15, zip_code: 80918, condition_id: condition.id)

      expect(Trip.worst_bike).to eq(15)
      expect(Trip.worst_bike_trip_count).to eq(1)
    end
  end

  describe ".sub_type_count" do
    it "returns subscription type counts" do
      subscription  = SubscriptionType.create(name: "Customer")
      subscription_2  = SubscriptionType.create(name: "Subscriber")
      subscription_3  = SubscriptionType.create(name: "Subscriber")

      expect(Trip.sub_type_count).to eq(1)
      expect(Trip.subscribers).to eq(2)
    end

    it "returns the total number of subscription types" do
      subscription    = SubscriptionType.create(name: "Customer")
      subscription_2  = SubscriptionType.create(name: "Subscriber")
      subscription_3  = SubscriptionType.create(name: "Subscriber")

      expect(Trip.total_subs).to eq(3)
    end

    it "returns the subscription types percentages" do
      subscription    = SubscriptionType.create(name: "Customer")
      subscription_2  = SubscriptionType.create(name: "Subscriber")
      subscription_3  = SubscriptionType.create(name: "Subscriber")

      expect(Trip.customer_percentage).to eq(33.0)
      expect(Trip.subscriber_percentage).to eq(67.0)
    end
  end

  describe ".conditions_on_top_date" do
    it "returns the conditions on the top date with the most trips" do

      expect(Trip.conditions_on_top_date).to eq("something")
    end
  end
end
