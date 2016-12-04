class CreateTrips < ActiveRecord::Migration[5.0]
  def change
    create_table :trips do |t|
      t.integer :duration
      t.time    :start_date
      t.time    :end_date
      t.integer :end_station_id
      t.integer :bike_id
      t.string  :subscription_type
      t.integer :zip_code

      t.timestamps null: false
    end
  end
end
