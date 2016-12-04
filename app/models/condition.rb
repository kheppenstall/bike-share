class Condition < ActiveRecord::Base
  has_many :trips
  has_many :stations, through: :trips
end
