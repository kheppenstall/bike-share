require './spec/spec_helper'

describe "Station" do
  describe "attributes" do
    it "has name" do
      Station.create(name: "Dock", dock_count: 20, installation_date: "07/21/2009")
    end
  end
end


# describe "Film" do
  
#   describe ".total_sales" do
    
#     it "returns the total sales for all films" do
#       Film.create(title: "Film1", year: 2012, box_office_sales: 3)
#       Film.create(title: "Film2", year: 2013, box_office_sales: 2)
#       expect(Film.total_sales).to eq(5)
#     end

#     it "returns zero when there are no films" do
#       expect(Film.total_sales).to eq(0)
#     end

#     it "scopes down to a single director" do
#       director_one = Director.create(name: "Name1")
#       director_one.films.create(title: "Film1", year: 2012, box_office_sales: 3)
#       director_two = Director.create(name: "Name2")
#       director_two.films.create(title: "Film2", year: 2013, box_office_sales: 2)
#       expect(director_one.films.total_sales).to eq(3)
#     end
#   end

#   describe ".average_sales" do
    
#     it "returns the average sales for all films" do
#       Film.create(title: "Film1", year: 2012, box_office_sales: 3)
#       Film.create(title: "Film2", year: 2013, box_office_sales: 2)
#       expect(Film.average_sales).to eq(2.5)
#     end

#     it "returns zero when there are no films" do
#       expect(Film.average_sales).to eq(0)
#     end
#   end

#   describe "validations" do
    
#     it "presence of title" do
#       invalid_film = Film.create(year: 2012, box_office_sales: 3)
#       expect(invalid_film).to be_invalid
#     end

#     it "uniqueness of title" do
#       film_one = Film.create(title: "Repeated Title", year: 2012, box_office_sales: 3)
#       film_two = Film.new(title: "Repeated Title", year: 2012, box_office_sales: 3)
#       expect(film_two).to be_invalid
#     end

#     it "presence of year" do
#       invalid_film = Film.new(title: "Title", box_office_sales: 3)
#       expect(invalid_film).to be_invalid
#     end

#     it "presence of box office sales" do
#       invalid_film = Film.create(title: "Title", year: 2012)
#       expect(invalid_film).to be_invalid
#     end
#   end
# end