class AddEventIdToBids < ActiveRecord::Migration[5.1]
  def change
    add_column :bids, :event_name, :string, unique: true, :null => false
  end
end
