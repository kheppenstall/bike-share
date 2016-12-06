module Precipitation

  def conditions_from_precip(precip_ceil)
    ceil = precip_ceil.to_f
    return all.where(precipitation: 0) if ceil == 0
    all.find_all do |condition|
      condition.precipitation <= ceil && condition.precipitation > ceil - 0.5
    end
  end

  def average_number_of_rides_from_precip(precip_ceil)
    conditions = conditions_from_precip(precip_ceil)
    average_rides(conditions)
  end

  def highest_number_of_rides_from_precip(precip_ceil)
    conditions = conditions_from_precip(precip_ceil)
    highest_number_of_rides(conditions)
  end

  def lowest_number_of_rides_from_precip(precip_ceil)
    conditions = conditions_from_precip(precip_ceil)
    lowest_number_of_rides(conditions)
  end

end