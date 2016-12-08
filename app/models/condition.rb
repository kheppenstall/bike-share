require_relative 'next_previous'
require_relative 'condition_dashboard'

class Condition < ActiveRecord::Base
  has_many :trips
  has_many :stations, through: :trips

  validates :date,    presence: true, uniqueness: true

  include NextPrevious
  extend ConditionDashboard
end
