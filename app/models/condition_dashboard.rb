require_relative 'names'

module ConditionDashboard

  def average_number_of_rides(temp_floor, date)
    conditions = where(date: date)
    return 0 if conditions.count.zero?
    (conditions.trips.count / conditions.count).round(1)
  end
end


# Breakout of average number of rides, highest number of rides, 
# and lowest number of rides on days with a high temperature 
# in 10 degree chunks (e.g. average number of rides on days with 
# high temps between fifty and sixty degrees)

# Breakout of average number of rides, highest number of rides, and lowest number of rides on days with precipitation in half-inch increments.
# Breakout of average number of rides, highest number of rides, and lowest number of rides on days with mean wind speeds in four mile increments.
# Breakout of average number of rides, highest number of rides, and lowest number of rides on days with mean visibility in miles in four mile increments.