require './app/models/condition_dashboard/precipitation'
require './app/models/condition_dashboard/visibility'
require './app/models/condition_dashboard/wind_speed'
require './app/models/condition_dashboard/temperature'

module ConditionDashboard

  include Precipitation 
  include Visibility
  include WindSpeed
  include Temperature

  def average(array)
    return 0 if array.count.zero?
    (array.reduce(:+).to_f / array.count).round(1)
  end
end