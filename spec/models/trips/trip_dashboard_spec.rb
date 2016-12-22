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

      expect(Trip.average_duration_of_ride).to eq(4.17)
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

      expect(Trip.longest_ride).to eq(5.0)
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

      expect(Trip.shortest_ride).to eq(3.33)
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
                          end_date: "02/01/2016", station_id: start_station.id, end_station_id: final_station.id,
                          bike_id: 14, zip_code: 80918, condition_id: condition.id)
      trip_2        = subscription.trips.create(duration: 200, start_date: "01/01/2016",
                          end_date: "02/01/2016", station_id: start_station.id, end_station_id: final_station.id,
                          bike_id: 14, zip_code: 80918, condition_id: condition.id)
      trip_3       = subscription.trips.create(duration: 200, start_date: "01/01/2016",
                          end_date: "02/01/2016", station_id: start_station.id, end_station_id: final_station.id,
                          bike_id: 14, zip_code: 80918, condition_id: condition.id)

      expect(Trip.start_station_with_most_rides).to eq(start_station.name)
    end

    it "returns empty string if there are no trips" do

      expect(Trip.start_station_with_most_rides).to eq("")
    end
  end

  describe ".end_station_with_most_rides" do
    it "returns the end station with the most rides" do
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
      trip_3       = subscription.trips.create(duration: 200, start_date: "01/01/2016",
                          end_date: "02/01/2016", station_id: start_station.id, end_station_id: start_station.id,
                          bike_id: 14, zip_code: 80918, condition_id: condition.id)

      expect(Trip.end_station_with_most_rides).to eq(final_station.name)
    end

    it "returns an empty string if there is no station" do

      expect(Trip.end_station_with_most_rides).to eq("")
    end
  end

  describe ".rides_per_month" do
    it "returns the rides for the month of august" do
      start_station = Station.create(name: "Dock", dock_count: 20, installation_date: "01/01/2015", city_id: 1)
      final_station = Station.create(name: "Dock1", dock_count: 20, installation_date: "01/01/2015", city_id: 1)
      subscription  = SubscriptionType.create(name: "Customer")
      condition     = Condition.create(date: "02/01/1990")
      trip          = subscription.trips.create(duration: 300, start_date: "08/08/2014",
                          end_date: "02/01/2016", station_id: start_station.id, end_station_id: final_station.id,
                          bike_id: 14, zip_code: 80918, condition_id: condition.id)
      trip_2        = subscription.trips.create(duration: 200, start_date: "08/08/2014",
                          end_date: "02/01/2016", station_id: start_station.id, end_station_id: final_station.id,
                          bike_id: 14, zip_code: 80918, condition_id: condition.id)
      trip_3       = subscription.trips.create(duration: 200, start_date: "08/08/2014",
                          end_date: "02/01/2016", station_id: final_station.id, end_station_id: start_station.id,
                          bike_id: 14, zip_code: 80918, condition_id: condition.id)
      trip_3       = subscription.trips.create(duration: 200, start_date: "09/09/2014",
                          end_date: "02/01/2016", station_id: final_station.id, end_station_id: start_station.id,
                          bike_id: 14, zip_code: 80918, condition_id: condition.id)

      expect(Trip.rides_per_month(8, 2014)).to eq(3)
      expect(Trip.rides_per_month(8, 2015)).to eq(0)
      expect(Trip.rides_per_month(9, 2014)).to eq(1)
    end

    it "retruns none if there are no trips" do

      expect(Trip.rides_per_month(1, 2016)).to eq(0)
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

  describe ".best_bike_count" do
    it "returns the trip count of the top bike id" do
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
                      bike_id: 14, zip_code: 80918, condition_id: condition.id)

      expect(Trip.best_bike_count).to eq(3)
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
    end
  end

  describe ".worst_bike_count" do
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

      expect(Trip.worst_bike_count).to eq(1)
    end
  end


  describe ".sub_type_count" do
    it "returns an array" do
      subscription    = SubscriptionType.create(name: "Customer")
      subscription_2  = SubscriptionType.create(name: "Subscriber")
      subscription_3  = SubscriptionType.create(name: "Subscriber")

      expect((Trip.sub_type_count).class).to eq(Array)
    end
  end

  describe ".sub_percent and .cust_percent" do
    it "returns the percentage of subscribers and customers" do
      start_station = Station.create(name: "Dock", dock_count: 20, installation_date: "01/01/2015", city_id: 1)
      final_station = Station.create(name: "Dock1", dock_count: 20, installation_date: "01/01/2015", city_id: 1)
      subscription  = SubscriptionType.create(name: "Customer")
      subscription_1  = SubscriptionType.create(name: "Subscriber")
      condition     = Condition.create(date: "02/01/1990")
      trip          = subscription.trips.create(duration: 300, start_date: "01/01/2016",
                      end_date: "02/01/2016", station_id: start_station.id, end_station_id: final_station.id,
                      bike_id: 14, zip_code: 80918, condition_id: condition.id)
      trip_2        = subscription.trips.create(duration: 200, start_date: "01/01/2016",
                      end_date: "02/01/2016", station_id: start_station.id, end_station_id: final_station.id,
                      bike_id: 14, zip_code: 80918, condition_id: condition.id)
      trip_3        = subscription_1.trips.create(duration: 200, start_date: "01/01/2016",
                      end_date: "02/01/2016", station_id: start_station.id, end_station_id: final_station.id,
                      bike_id: 15, zip_code: 80918, condition_id: condition.id)

      expect(Trip.sub_percent).to eq(33.33)
      expect(Trip.cust_percent).to eq(66.67)
    end
  end

  describe ".top_trips_per_date" do
    it "returns the date with the highest trip count" do
      start_station = Station.create(name: "Dock", dock_count: 20, installation_date: "01/01/2015", city_id: 1)
      final_station = Station.create(name: "Dock1", dock_count: 20, installation_date: "01/01/2015", city_id: 1)
      subscription  = SubscriptionType.create(name: "Customer")
      subscription_1  = SubscriptionType.create(name: "Subscriber")
      condition     = Condition.create(date: "02/01/1990")
      trip          = subscription.trips.create(duration: 300, start_date: "01/01/2016",
                      end_date: "02/01/2016", station_id: start_station.id, end_station_id: final_station.id,
                      bike_id: 14, zip_code: 80918, condition_id: condition.id)
      trip_2        = subscription.trips.create(duration: 200, start_date: "01/01/2016",
                      end_date: "02/01/2016", station_id: start_station.id, end_station_id: final_station.id,
                      bike_id: 14, zip_code: 80918, condition_id: condition.id)
      trip_3        = subscription_1.trips.create(duration: 200, start_date: "01/01/2016",
                      end_date: "02/01/2016", station_id: start_station.id, end_station_id: final_station.id,
                      bike_id: 15, zip_code: 80918, condition_id: condition.id)

      expect((Trip.top_trips_per_date).class).to eq(Array)
      expect((Trip.top_trips_per_date[0]).class).to eq(Date)
      expect((Trip.top_trips_per_date[1]).class).to eq(Fixnum)
      expect(Trip.top_trips_per_date[1]).to eq(3)
    end
  end

  describe ".lowest_trips_per_date" do
    it "returns the date with the lowest trip count" do
      start_station = Station.create(name: "Dock", dock_count: 20, installation_date: "01/01/2015", city_id: 1)
      final_station = Station.create(name: "Dock1", dock_count: 20, installation_date: "01/01/2015", city_id: 1)
      subscription  = SubscriptionType.create(name: "Customer")
      subscription_1  = SubscriptionType.create(name: "Subscriber")
      condition     = Condition.create(date: "02/01/1990")
      trip          = subscription.trips.create(duration: 300, start_date: "01/01/2016",
                      end_date: "02/01/2016", station_id: start_station.id, end_station_id: final_station.id,
                      bike_id: 14, zip_code: 80918, condition_id: condition.id)
      trip_2        = subscription.trips.create(duration: 200, start_date: "01/01/2016",
                      end_date: "02/01/2016", station_id: start_station.id, end_station_id: final_station.id,
                      bike_id: 14, zip_code: 80918, condition_id: condition.id)
      trip_3        = subscription_1.trips.create(duration: 200, start_date: "02/01/2016",
                      end_date: "02/01/2016", station_id: start_station.id, end_station_id: final_station.id,
                      bike_id: 15, zip_code: 80918, condition_id: condition.id)

      expect((Trip.lowest_trips_per_date).class).to eq(Array)
      expect((Trip.lowest_trips_per_date[0]).class).to eq(Date)
      expect((Trip.lowest_trips_per_date[1]).class).to eq(Fixnum)
    end
  end
end
