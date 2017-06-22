class AddSavedBidToBids < ActiveRecord::Migration[5.1]
  def change
    add_column :bids, :saved_bid, :string
  end
end
