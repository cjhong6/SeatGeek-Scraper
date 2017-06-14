class CreateBids < ActiveRecord::Migration[5.1]
  def change
    create_table :bids do |t|
      t.string :lowest_price
      t.integer :user_id
      t.string :offer_price

      t.timestamps
    end
  end
end
