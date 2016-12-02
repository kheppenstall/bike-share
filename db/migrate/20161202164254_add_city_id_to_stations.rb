class AddCityIdToStations < ActiveRecord::Migration[5.0]
  def change
    add_column :stations, :city_id, :integer
  end
end
