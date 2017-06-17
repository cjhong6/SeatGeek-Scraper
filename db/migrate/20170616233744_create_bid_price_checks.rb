class CreateBidPriceChecks < ActiveRecord::Migration[5.1]
  def change
    create_table :bid_price_checks do |t|
      t.string :lowest_price
      t.integer :bid_id
      t.timestamps
    end
  end
end
