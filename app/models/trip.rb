class Trip < ActiveRecord::Base
  belongs_to  :condition
  belongs_to  :station
  belongs_to  :subscription_type
  validates   :duration,             presence: true
  validates   :start_date,           presence: true
  validates   :bike_id,              presence: true
  validates   :zip_code,             presence: true
  validates   :station_id,           presence: true
  validates   :condition_id,         presence: true
  validates   :subscription_type_id, presence: true
end
