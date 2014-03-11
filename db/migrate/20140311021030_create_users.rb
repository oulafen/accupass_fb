class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :password_confirmation
      t.string :forgot_pw_question
      t.string :forgot_pw_answer

      t.timestamps
    end
  end
end
