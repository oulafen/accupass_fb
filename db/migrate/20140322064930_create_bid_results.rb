class CreateBidResults < ActiveRecord::Migration
  def change
    create_table :bid_results do |t|
      t.string :activity_name
      t.string :bid_name
      t.string :user
      t.string :name
      t.string :phone
      t.string :price
      t.string :status

    end
  end
end
