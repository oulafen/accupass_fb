class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.string :activity_name
      t.string :bid_name
      t.string :user
      t.string :bid_status

      t.timestamps
    end
  end
end
