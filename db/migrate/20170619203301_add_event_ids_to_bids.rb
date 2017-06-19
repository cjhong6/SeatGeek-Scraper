class AddEventIdsToBids < ActiveRecord::Migration[5.1]
  def change
    add_column :bids, :event_id, :integer
  end
end
