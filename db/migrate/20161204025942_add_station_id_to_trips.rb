class AddStationIdToTrips < ActiveRecord::Migration[5.0]
  def change
    add_column :trips, :station_id, :integer
  end
end
