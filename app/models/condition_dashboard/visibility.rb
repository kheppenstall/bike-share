module Visibility

  def conditions_from_visibility(visibility_floor)
    all.find_all do |condition|
      speed = condition.mean_visibility
      speed >= visibility_floor && speed < visibility_floor + 4
    end
  end

  def average_number_of_rides_from_visibility(visibility_floor)
    conditions = conditions_from_visibility(visibility_floor)
    average_rides(conditions)
  end

  def highest_number_of_rides_from_visibility(visibility_floor)
    conditions = conditions_from_visibility(visibility_floor)
    highest_number_of_rides(conditions)
  end

  def lowest_number_of_rides_from_visibility(visibility_floor)
    conditions = conditions_from_visibility(visibility_floor)
    lowest_number_of_rides(conditions)
  end
  
end