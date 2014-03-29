class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :activity_name
      t.string :user
      t.string :bid_name
      t.string :name
      t.string :phone
      t.string :price

      t.timestamps
    end
  end
end
