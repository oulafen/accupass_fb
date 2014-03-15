class AddAttributeToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :token, :string
    add_column :users, :attribute, :string
  end
end
