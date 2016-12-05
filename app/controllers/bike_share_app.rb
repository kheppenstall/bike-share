class BikeShareApp < Sinatra::Base

  get '/stations' do
    @stations = Station.all
    erb :"stations/index"
  end

  get '/stations-dashboard' do
    @stations = Station.all
    erb :"stations/dashboard"
  end

  get '/stations/new' do
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
























































## Trip CRUD ###

  get '/trips' do
    redirect '/trips/page/1'
  end

  get '/trips/page/:num' do |num|
    n          = num.to_i
    range      = (((n - 1) * 30)..(n * 30 - 1))
    @pages     = (Trip.count / 30.to_f).ceil
    @trips     = Trip.all[range]
    erb :"trips/index"
  end

  get '/trips/new' do
    @stations = Station.all
    erb :"trips/new"
  end

  get '/trips/:id' do |id|
    @trip = Trip.find(id)
    erb :"trips/show"
  end

  delete '/trips/:id' do |id|
    Trip.delete(id)
    redirect ('/trips')
  end


end
