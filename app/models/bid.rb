class Bid < ApplicationRecord
  has_many :bid_price_check
  belongs_to :user
end
