require_relative 'condition_dashboard'

class Condition < ActiveRecord::Base
  has_many :trips
  has_many :stations, through: :trips

  validates :date,    presence: true, uniqueness: true

<<<<<<< HEAD
  # extend ConditionDashboard
end
=======
  extend ConditionDashboard
end
>>>>>>> master
