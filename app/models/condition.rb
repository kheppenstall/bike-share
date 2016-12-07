require_relative 'next_previous'
require_relative 'condition_dashboard'

class Condition < ActiveRecord::Base
  has_many :trips
  has_many :stations, through: :trips

  validates :date,    presence: true, uniqueness: true

  include NextPrevious
  extend ConditionDashboard

  def weather_information
    "#{date}, #{max_temperature}, #{mean_temperature}, #{min_temperature}, #{mean_humidity}, #{mean_visibility}, #{mean_wind_speed}, #{precipitation}"
  end
end
