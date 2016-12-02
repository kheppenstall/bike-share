class Station < ActiveRecord::Base
  belongs_to :city
  validates :name, presence: true, uniqueness: true
  validates :dock_count, presence: true
  validates :installation_date, presence: true
  validates :city_id, presence: true
end