class SubscriptionType < ActiveRecord::Base
  has_many :trips
end
