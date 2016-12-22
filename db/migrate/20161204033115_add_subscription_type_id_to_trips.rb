class AddSubscriptionTypeIdToTrips < ActiveRecord::Migration[5.0]
  def change
    add_column :trips, :subscription_type_id, :integer
  end
end
