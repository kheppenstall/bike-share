require 'pry'

class BikeShareApp < Sinatra::Base

  get '/stations' do
    @stations = Station.all
    erb :"stations/index"
  end

  get '/stations/new' do
    erb :"stations/new"
  end

  get '/stations/:id' do |id|
    @station = Station.find(id.to_i)
    erb :"stations/show"
  end

  post '/stations' do
    city_name = params["city"]
    city      = City.find_or_create_by(name: city_name)
    station   = city.stations.create(params["station"])
    redirect "/stations/#{station.id}"
  end


end
