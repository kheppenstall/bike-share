class AddConditionIdToTrips < ActiveRecord::Migration[5.0]
  def change
    add_column :trips, :condition_id, :integer
  end
end
