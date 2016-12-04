class Trip < ActiveRecord::Base
  belongs_to  :conditions
  belongs_to  :stations
  belongs_to  :subscription_types
end
