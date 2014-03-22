class CreateBidPeople < ActiveRecord::Migration
  def change
    create_table :bid_people do |t|
      t.string :activity_name
      t.string :bid_name
      t.string :user
      t.string :name
      t.string :phone
      t.string :price

    end
  end
end
