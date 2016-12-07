require_relative 'pagination'

class BikeShareApp < Sinatra::Base

  include Pagination

  get '/' do
    redirect '/stations'
  end

  get '/stations' do
    @stations = Station.all
    erb :"stations/index"
  end

  get '/stations-dashboard' do
    erb :"stations/dashboard"
  end

  get '/stations/new' do
    @cities = City.all
    erb :"stations/new"
  end

  get '/stations/:id' do |id|
    @station = Station.find(id)
    erb :"stations/show"
  end

  post '/stations' do
    city_name = params["city"]
    city      = City.find_or_create_by(name: city_name)
    station   = city.stations.create(params["station"])
    redirect "/stations/#{station.id}"
  end

  get '/stations/:id/edit' do |id|
    @station = Station.find(id)
    @cities = City.all
    erb :"stations/edit"
  end

  put '/stations/:id' do |id|
    @station = Station.find(id)
    city_name = params["city"]
    city      = City.find_or_create_by(name: city_name)
    @station.update(params["station"])
    @station.update(city_id: city.id)
    redirect "/stations/#{id}"
  end

  delete '/stations/:id' do |id|
    Station.delete(id)
    redirect '/stations'
  end



########################################
  get '/conditions-dashboard' do
    @conditions = Condition.all
    erb :"conditions/dashboard"
  end

  get '/conditions' do
    redirect '/conditions/page/1'
  end

  get '/conditions/page/:num' do |page_num|
    @conditions = on_page(Condition.all, page_num.to_i)
    @next = next_page(page_num.to_i, Condition.count)
    @previous = previous_page(page_num.to_i)
    erb :"conditions/index"
  end

  get '/conditions/new' do
    erb :"conditions/new"
  end

  get '/conditions/:id' do |id|
    @condition = Condition.find(id)
    erb :"conditions/show"
  end

  post '/conditions' do
    condition = Condition.create(params["condition"])
    redirect "/conditions/#{condition.id}"
  end

  get '/conditions/:id/edit' do |id|
    @condition = Condition.find(id)
    erb :"conditions/edit"
  end

  put '/conditions/:id' do |id|
    @condition = Condition.find(id)
    @condition.update(params[:condition])
    redirect "/conditions/#{id}"
  end

  post '/conditions/:id' do |id|
    condition = Condition.update(params["condition"])
    redirect "/conditions"
  end

  delete '/conditions/:id' do |id|
    Condition.delete(id)
    redirect '/conditions'
  end

  get '/conditions-dashboard' do
    erb :"conditions/dashboard"
  end
















































############### Trip CRUD ###################

  get '/trips' do
    redirect '/trips/page/1'
  end

  get '/trips-dashboard' do
    erb :"trips/dashboard"
  end

  get '/trips/page/:num' do |page_num|
    @trips     = on_page(Trip.all, page_num.to_i)
    @next = next_page(page_num.to_i, Trip.count)
    @previous = previous_page(page_num.to_i)
    erb :"trips/index"
  end

  get '/trips/new' do
    @stations = Station.all
    @subscription_types = SubscriptionType.all
    erb :"trips/new"
  end

  get '/trips/:id' do |id|
    @trip = Trip.find(id)
    erb :"trips/show"
  end

  post '/trips' do
    trip_information  = params['trip']
    start_date        = Time.parse(trip_information["start_date"])
    end_date          = Time.parse(trip_information["end_date"])
    bike_id           = trip_information["bike_id"]
    zipcode           = trip_information["zip_code"]
    start_station     = Station.find_by(name: trip_information["start_station_name"])
    end_station       = Station.find_by(name: trip_information["end_station_name"])
    duration          = (end_date - start_date).to_i
    condition         = Condition.find_by(date: "#{start_date.to_date}")
    condition_id      = condition.id rescue nil
    subscription_type = SubscriptionType.find_by(name: trip_information['subscription_type'])
    trip              = Trip.create(duration: duration, start_date: start_date,
                        end_date: end_date, station_id: start_station.id, end_station_id: end_station.id,
                        bike_id: bike_id, zip_code: zipcode,
                        condition_id: condition_id, subscription_type_id: subscription_type.id)
    redirect("/trips/#{trip.id}")
  end

  get '/trips/:id/edit' do |id|
    @trip               = Trip.find(id)
    @stations           = Station.all
    @subscription_types = SubscriptionType.all
    erb :"trips/edit"
  end

  put '/trips/:id' do |id|
    @trip = Trip.find(id)
    trip_information  = params['trip']
    start_date        = Time.parse(trip_information["start_date"])
    end_date          = Time.parse(trip_information["end_date"])
    duration          = (end_date - start_date).to_i
    start_station     = Station.find_by(name: trip_information['start_station_name']).id
    end_station       = Station.find_by(name: trip_information["end_station_name"]).id
    bike_id           = trip_information['bike_id']
    zip_code          = trip_information['zip_code']
    condition         = Condition.find_by(date: "#{start_date.to_date}")
    condition_id      = condition.id rescue nil
    subscription_type = SubscriptionType.find_by(name: trip_information['subscription_type'])
    @trip.update(duration: duration,
                start_date: start_date, end_date: end_date,
                end_station_id: end_station, bike_id: bike_id,
                zip_code: zip_code, station_id: start_station, condition_id: condition_id,
                subscription_type_id: subscription_type.id)
    redirect "/trips/#{@trip.id}"
  end

  delete '/trips/:id' do |id|
    Trip.delete(id)
    redirect ('/trips/page/1')
  end
end
