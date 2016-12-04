class Trip < ActiveRecord::Base
  belongs_to  :conditions
  belongs_to  :stations
end
