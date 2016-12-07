class Condition < ActiveRecord::Base
  has_many :trips
  has_many :stations, through: :trips
  validates :date,    presence: true, uniqueness: true

  # extend ConditionDashboard
end
