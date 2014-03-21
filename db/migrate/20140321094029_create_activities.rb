class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :activity_id
      t.string :name
      t.string :user
      t.string :status

      t.timestamps
    end
  end
end
