require 'pry'

class BikeShareApp < Sinatra::Base

  get '/stations' do
    @stations = Station.all
    erb :"stations/index"
  end


end
