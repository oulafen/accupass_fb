class CreateSignUps < ActiveRecord::Migration
  def change
    create_table :sign_ups do |t|
      t.string :activity_id
      t.string :user
      t.string :name
      t.string :phone
      t.string :status

      t.timestamps
    end
  end
end
